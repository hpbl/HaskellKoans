module Model.KoanManager 
 (
    koans,
    answeredKoan,
    getKoan,
    themes
 ) where

import Model.Koan (Koan(..), isRightAnswer)
import Model.LocalKoans (localKoans)
import Helpers.RoutingHelper (redirect)
import Pages.Exercise (exercise)

import Happstack.Server (ServerPart, looks, look, Response, ok, toResponse)
import Control.Monad
import Control.Applicative (optional)
import Data.List (group)

-- List of available koans by theme--
koans :: [[Koan]]
koans = localKoans -- TODO: Replace with DB data

-- Recieves the index of current koan and returns the next one along with it's index --
getNextKoan :: (Int, Int) -> Maybe (Int, Int)
getNextKoan (themeIndex, koanIndex)
    | hasNextRow = Just (themeIndex, koanIndex + 1) -- get next from same theme
    | hasNextColumn = Just (themeIndex + 1, 0)      -- get first from next theme
    | otherwise = Nothing                           -- finished koans 
        where hasNextColumn = themeIndex < ((length koans) - 1)
              currentTheme = koans !! themeIndex
              hasNextRow = koanIndex < ((length currentTheme) - 1)

getPreviousKoan :: (Int, Int) -> Maybe (Int, Int)
getPreviousKoan (themeIndex, koanIndex)
    | hasPreviousRow    = Just (themeIndex, koanIndex - 1)
    | haspreviousColumn = Just (themeIndex - 1, (length previousColumn) - 1)
    | otherwise         = Nothing
        where hasPreviousRow    = koanIndex > 0
              haspreviousColumn = themeIndex > 0
              previousColumn    = koans !! (themeIndex - 1)


getKoan :: (Int, Int) -> Koan
getKoan (themeIndex, koanIndex) = (koans !! themeIndex) !! koanIndex


-- Check koan answer --
checkAnswer :: (Int, Int) -> String -> Bool
checkAnswer indexes answer = isRightAnswer koan answer
    where koan = getKoan indexes


-- List of themes form koans --
themes :: [String]
themes = map (theme . head) localKoans


-- Check user response for a koan and redirect accordingly -- 
presentNextKoan :: Maybe (Int, Int) -> ServerPart Response
presentNextKoan (Just (themeIndex, koanIndex)) = redirect $  "../" ++ (show $ themeIndex) ++ "/" ++ (show $ koanIndex)
presentNextKoan Nothing = redirect "../../finished"

presentPreviousKoan :: Maybe (Int, Int) -> ServerPart Response
presentPreviousKoan Nothing = redirect "../../"
presentPreviousKoan indexes = presentNextKoan indexes

answeredKoan :: ServerPart Response
answeredKoan = do answer  <- look "answer"
                  theme   <- look "themeNumber"
                  number  <- look "koanNumber"
                  back    <- optional $ look "back"
                  let koanIndex  = read number
                  let themeIndex = read theme
                  let indexes = (themeIndex, koanIndex)
                  if (back /= Nothing)
                    then 
                      presentPreviousKoan $ getPreviousKoan indexes
                    else do
                      if checkAnswer indexes answer
                        then presentNextKoan $ getNextKoan indexes
                        else  exercise (getKoan indexes, themeIndex, koanIndex, "try again")
                  