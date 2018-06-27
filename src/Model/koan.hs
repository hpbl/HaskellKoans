module Model.Koan
 (
    Koan(..),
    codeParts,
    isRightAnswer
 )where


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
codeParts koan = splitOnKeyword (code koan) ""


-- splits a string into two parts (before, after) keyword
splitOnKeyword :: String -> String -> (String, String)
splitOnKeyword [] _         = error "couldn't find keyword"
splitOnKeyword (x:xs) accum = if x == keyword
                                then (accum, xs)
                                else splitOnKeyword xs (accum ++ [x])


-- checks if the given answer is correct
isRightAnswer :: Koan -> String -> Bool
isRightAnswer koan givenAnswer = (answer koan) == givenAnswer
    