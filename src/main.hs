{-# LANGUAGE OverloadedStrings #-}
module Main where

import Happstack.Server
import Control.Monad (msum)

import Pages.Index (index)
import Pages.Koans (koans)


main :: IO ()
main = simpleHTTP nullConf $ msum [
                                    dir "img" $ serveDirectory DisableBrowsing [] "img/",
                                    dir "style" $ serveDirectory DisableBrowsing [] "style/",
                                    dir "koans" $ koans,
                                    index
                                  ]