module Model.Koan
 (
    Koan(..),
    codeParts,
    koans,
    checkAnswer
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
checkAnswer :: Koan -> String -> Bool
checkAnswer koan givenAnswer = (answer koan) == givenAnswer


-- list of koans --
koans :: [Koan]
koans = [
        Koan { theme="Equality", intro="We shall contemplate truth by testing reality, via equality", code="True /= #", answer="False" },
        Koan { theme="Equality", intro="What is cannot be not", code="True == #", answer="True" }
    ]
    