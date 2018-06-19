{-# LANGUAGE OverloadedStrings #-}
module Main where

import Happstack.Server
import Control.Monad (msum)

import Pages.Index (index)
import Pages.Exercise (exercise)
import Pages.Finished (finished)
import Model.Koan (Koan, koans)
import qualified Text.Blaze.Html4.Strict as H

main :: IO ()
main = simpleHTTP nullConf $ handlers

myPolicy :: BodyPolicy
myPolicy = (defaultBodyPolicy "/tmp/" 0 1000 1000)

handlers :: ServerPart Response
handlers =
    do decodeBody myPolicy
       msum [
                dir "img" $ serveDirectory DisableBrowsing [] "img/",
                dir "style" $ serveDirectory DisableBrowsing [] "style/",
                dir "koans" $ msum[
                    Happstack.Server.method GET >> path (\number -> exercise ((koans !! number), number)),
                    Happstack.Server.method POST >> responded
                ],
                dir "finished" $ finished,
                index
            ]


-- Responded
responded :: ServerPart Response
responded = do
                answer <- look "answer"
                number <- look "koanNumber"
                exercise $ getNextKoan (read number :: Int)

getNextKoan :: Int -> (Koan, Int)
getNextKoan current = if current < (length koans) - 1
                            then (koans !! (current + 1), current + 1)
                            else error "Next topic please!"



