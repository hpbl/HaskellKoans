module Model.Koan
 (
    Koan(..),
    codeParts,
    isRightAnswer,
 )where

import Helpers.RoutingHelper (splitOnKeyword)


-- Data type for our exercises (koans)
data Koan = Koan {
    theme  :: String,
    intro  :: String,
    code   :: String,
    answer :: String
} deriving (Show)


-- keyword used as placehlder for user input
keyword :: Char
keyword = '#'


-- koan code parts
codeParts :: Koan -> (String, String)
codeParts koan = splitOnKeyword (code koan) "" keyword


-- checks if the given answer is correct
isRightAnswer :: Koan -> String -> Bool
isRightAnswer koan givenAnswer = (answer koan) == givenAnswer
    