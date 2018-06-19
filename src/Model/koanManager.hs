module Model.KoanManager 
 (
    koans,
    answeredKoan
 ) where

import Model.Koan (Koan(..), isRightAnswer)
import Helpers.RoutingHelper (redirect)

import Happstack.Server (ServerPart, look, Response)

-- List of available koans --
koans :: [Koan]
koans = [
        Koan { theme="Equality", intro="We shall contemplate truth by testing reality, via equality", code="True /= #", answer="False" },
        Koan { theme="Equality", intro="What is cannot be not", code="True == #", answer="True" }
    ]


-- Recieves the index of current koan and returns the next one along with it's index --
getNextKoanIndex :: Int -> Int
getNextKoanIndex current = if current < (length koans) - 1
                            then current + 1
                            else error "Next topic please!"


-- Check koan answer --
checkAnswer :: Int -> String -> Bool
checkAnswer index answer = isRightAnswer koan answer
    where koan = koans !! index


-- Check user response for a koan and redirect accordingly -- 
answeredKoan :: ServerPart Response
answeredKoan = do answer <- look "answer"
                  number <- look "koanNumber"
                  if checkAnswer (read number) answer
                    then redirect (show $ getNextKoanIndex (read number))
                    else error "Wrong answer motherfucker!"
                  