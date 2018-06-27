{-# LANGUAGE DeriveGeneric, OverloadedStrings, ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-unused-binds #-}

module HTTPRequest(
  getKoans,
)
where


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

data Koan = Koan {
  id :: Int,
  sentence :: String,
  theme :: String,
  answer :: String
  } deriving (Show)


parseKoan :: Value -> Parser Koan
parseKoan = withObject "object" $ \o -> do
    id <- o .: "id"
    sentence <- o .: "sentence"
    theme <- o .: "theme"
    answer <- o .: "answer"
    return $ Koan id sentence theme answer

parseKoanList' :: Value -> Parser [Koan]
parseKoanList' = withArray "array" $ \arr ->
    mapM parseKoan (V.toList arr)

parseKoanList :: Value -> Parser [Koan]
parseKoanList = withObject "object" $ \o -> do
    rawData <- o .: "rawData"
    parseKoanList' rawData

getKoans :: Maybe a
printDataFromServer = do
  response <- (get "https://young-taiga-18731.herokuapp.com/data")
  let strJson = (case (response ^? responseBody) of
                   Just value -> value
                   Nothing -> Empty)
  let parseResult = (case decode strJson of
                  Just result -> Just (parse parseKoanList result)
                  Nothing -> Nothing)

  return parseResult
