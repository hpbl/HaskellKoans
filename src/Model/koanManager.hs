module Model.KoanManager 
 (
    koans,
    answeredKoan
 ) where

import Model.Koan (Koan(..), isRightAnswer)
import Helpers.RoutingHelper (redirect)
import Pages.Exercise (exercise)

import Happstack.Server (ServerPart, look, Response)

-- List of available koans --
koans :: [Koan]
koans = [
        Koan { theme="Equality", intro="We shall contemplate truth by testing reality, via equality", code="True /= #", answer="False" },
        Koan { theme="Equality", intro="What is cannot be not", code="True == #", answer="True" }
    ]


-- Recieves the index of current koan and returns the next one along with it's index --
getNextKoan :: Int -> ServerPart Response
getNextKoan current = if current < (length koans) - 1
                        then redirect (show $ current + 1)
                        else redirect "../finished"


-- Check koan answer --
checkAnswer :: Int -> String -> Bool
checkAnswer index answer = isRightAnswer koan answer
    where koan = koans !! index


-- Check user response for a koan and redirect accordingly -- 
answeredKoan :: ServerPart Response
answeredKoan = do answer <- look "answer"
                  number <- look "koanNumber"
                  let index = read number
                  if checkAnswer index answer
                    then getNextKoan index
                    else  exercise ((koans !! index), index, "try again")
                  