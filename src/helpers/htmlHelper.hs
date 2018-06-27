{-# LANGUAGE OverloadedStrings #-}
module Helpers.HtmlHelper where

import Happstack.Server
import Text.Blaze ((!))
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A


-- Building block for pages --
pageBuilder :: String -> [H.Html] -> H.Html -> H.Html
pageBuilder title headers body =
    H.html $ do
        H.head $ do
            H.title (H.toHtml title)
            H.meta ! A.httpEquiv "content-type" ! A.content "text/html;charset=utf-8"
            sequence_ headers
        H.body $ do
            body


-- Turns list text into <p> tags --
paragraphsToP :: [String] -> [H.Html]
paragraphsToP paragraphs = map (H.p . H.toHtml) paragraphs


-- Turns list text into <ul> --
itemsToUl :: [String] -> H.Html
itemsToUl items = H.ul $ do
                    sequence_ $ map (H.li . H.toHtml) items


-- An empty (flex: 1) div used for margin --
marginDiv :: H.Html
marginDiv = H.div ! A.class_ "margin" $ do
                     H.p "" -- TODO: Replace with empty div


-- Lorem Ipsum --
loremBuba :: Int -> String
loremBuba times = concat $ (replicate times "Belly Buba ")