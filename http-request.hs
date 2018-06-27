-- Examples of handling for JSON responses
--
-- This library provides several ways to handle JSON responses

{-# LANGUAGE DeriveGeneric, OverloadedStrings, ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-unused-binds #-}

import Control.Lens ((&), (^.), (^?), (.~))
import Data.ByteString.Lazy.Internal (ByteString(..))
import Data.Aeson (FromJSON(..), (.:), Value(..), decode)
import Data.Aeson.Types (parse, Parser, withArray, withObject)
import Data.Aeson.Lens (key)
import Data.Map (Map)
import Data.Text (Text)
import GHC.Generics (Generic)
import qualified Control.Exception as E
import qualified Data.Vector as V

import Network.Wreq


newtype KoanList = KoanList [Koan] deriving (Show)

data Koan = Koan {id :: Int, sentence :: String } deriving (Show)

-- instance FromJSON KoanList where
--   parseJSON (Object o) = do
--     (do rawData <- o .: "rawData" KoanList . V.toList <$> mapM parseJSON rawData)
--   parseJSON err = fail $ "Invalid type for KoanList: " ++ show err
--
-- instance FromJSON Koan where
--   parseJSON (Object o) = Koan <$> o .: "id" <*> o .: "sentence"
--   parseJSON err =  fail $ "Invalid type for Koan: " ++ show err

parseKoan :: Value -> Parser Koan
parseKoan = withObject "object" $ \o -> do
    id <- o .: "id"
    sentence <- o .: "sentence"
    return $ Koan id sentence

parseKoanList' :: Value -> Parser [Koan]
parseKoanList' = withArray "array" $ \arr ->
    mapM parseKoan (V.toList arr)

parseKoanList :: Value -> Parser [Koan]
parseKoanList = withObject "object" $ \o -> do
    rawData <- o .: "rawData"
    parseKoanList' rawData

printDataFromServer :: IO ()
printDataFromServer = do
  response <- (get "https://young-taiga-18731.herokuapp.com/data")
  let strJson = (case (response ^? responseBody) of
                   Just value -> value
                   Nothing -> Empty)

  case decode strJson of
    Just result -> print $ parse parseKoanList result
    Nothing -> fail "decoding failed"


main :: IO ()
main = do
  printDataFromServer
