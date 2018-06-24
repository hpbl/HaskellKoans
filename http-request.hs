-- Examples of handling for JSON responses
--
-- This library provides several ways to handle JSON responses

{-# LANGUAGE DeriveGeneric, OverloadedStrings, ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-unused-binds #-}

import Control.Lens ((&), (^.), (^?), (.~))
import Data.ByteString.Lazy.Internal (ByteString(..))
import Data.Aeson (FromJSON(..), (.:), Value(..), decode)
import Data.Aeson.Lens (key)
import Data.Map (Map)
import Data.Text (Text)
import GHC.Generics (Generic)
import qualified Control.Exception as E

import Network.Wreq


newtype KoanList = KoanList { koanList :: [Koan]}

instance FromJSON KoanList where
  parseJSON (Object o) = KoanList <$> o .: "rawData"

data Koan = Koan {id :: String, sentence :: String } deriving (Show)

instance FromJSON Koan where
  parseJSON (Object o) = Koan <$> o .: "id" <*> o .: "sentence"

printDataFromServer :: IO ()
printDataFromServer = do
  response <- get "https://young-taiga-18731.herokuapp.com/data"
  let result = (case (response ^? responseBody) of
                  Just value -> value
                  Nothing -> Empty)

  print $ koanList <$> decode result
  --print $ response


main :: IO ()
main = do
  printDataFromServer
