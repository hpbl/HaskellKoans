module Model.KoanManager 
 (
    koans,
    answeredKoan,
    getKoan
 ) where

import Model.Koan (Koan(..), isRightAnswer)
import Helpers.RoutingHelper (redirect)
import Pages.Exercise (exercise)

import Happstack.Server (ServerPart, looks, look, Response, ok, toResponse)
import Control.Monad

-- List of available koans by theme--
equalityKoans :: [Koan]
equalityKoans = [
    Koan { theme="Equality", intro="We shall contemplate truth by testing reality, via equality", code="True /= #", answer="False" },
    Koan { theme="Equality", intro="What is cannot be not", code="True == #", answer="True" }
  ]

arithmeticKoans :: [Koan]
arithmeticKoans = [
    Koan { theme="Arithmetic", intro="Hail to the thief", code="2 + # == 5", answer="3" },
    Koan { theme="Arithmetic", intro="Joãozinho tem 10 melões.", code="10 / 5 == #", answer="2" }
  ]

koans :: [[Koan]]
koans = [
    equalityKoans,
    arithmeticKoans
  ]

-- Recieves the index of current koan and returns the next one along with it's index --
presentKoan :: Maybe (Int, Int) -> ServerPart Response
presentKoan (Just (themeIndex, koanIndex)) = redirect $  "../" ++ (show $ themeIndex) ++ "/" ++ (show $ koanIndex)
presentKoan Nothing = redirect "../../finished"

getNextKoan :: (Int, Int) -> Maybe (Int, Int)
getNextKoan (themeIndex, koanIndex)
    | hasNextRow = Just (themeIndex, koanIndex + 1) -- get next from same theme
    | hasNextColumn = Just (themeIndex + 1, 0)      -- get first from next theme
    | otherwise = Nothing                           -- finished koans 
        where hasNextColumn = themeIndex < ((length koans) - 1)
              currentTheme = koans !! themeIndex
              hasNextRow = koanIndex < ((length currentTheme) - 1)


getKoan :: (Int, Int) -> Koan
getKoan (themeIndex, koanIndex) = (koans !! themeIndex) !! koanIndex


-- Check koan answer --
checkAnswer :: (Int, Int) -> String -> Bool
checkAnswer indexes answer = isRightAnswer koan answer
    where koan = getKoan indexes


-- Check user response for a koan and redirect accordingly -- 
answeredKoan :: ServerPart Response
answeredKoan = do answer <- look "answer"
                  theme  <- look "themeNumber"
                  number <- look "koanNumber"
                  back   <- looks "back"
                  if (back /= []) 
                    then ok $ toResponse "volte"
                    else do
                      let koanIndex  = read number
                      let themeIndex = read theme
                      let indexes = (themeIndex, koanIndex)
                      if checkAnswer indexes answer
                        then presentKoan $ getNextKoan indexes
                        else  exercise (getKoan indexes, themeIndex, koanIndex, "try again")
                  