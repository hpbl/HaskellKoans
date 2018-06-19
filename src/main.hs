
module Main where

import Happstack.Server
import Control.Monad (msum)

import Pages.Index (index)
import Pages.Exercise (exercise)
import Pages.Finished (finished)
import Model.KoanManager (koans, answeredKoan)


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
                    Happstack.Server.method POST >> answeredKoan
                ],
                dir "finished" $ finished,
                index
            ]






