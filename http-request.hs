-- Examples of handling for JSON responses
--
-- This library provides several ways to handle JSON responses

{-# LANGUAGE DeriveGeneric, OverloadedStrings, ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-unused-binds #-}

import Control.Lens ((&), (^.), (^?), (.~))
import Data.Aeson (FromJSON)
import Data.Aeson.Lens (key)
import Data.Map (Map)
import Data.Text (Text)
import GHC.Generics (Generic)
import qualified Control.Exception as E

import Network.Wreq

-- data type related to our json
data GetBody = GetBody {
    rawData :: Map Text Text
  } deriving (Show, Generic)

-- making it an FromJSON instance so we can parse it
instance FromJSON GetBody

-- it does an get request to our node server and processes the first part of our response JSON's three
printDataFromServer :: IO ()
printDataFromServer = do
  response <- get "https://young-taiga-18731.herokuapp.com/data"
  print $ response ^? responseBody . key "rawData"


main :: IO ()
main = do
  printDataFromServer
