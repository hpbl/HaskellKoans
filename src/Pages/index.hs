{-# LANGUAGE OverloadedStrings #-}
module Pages.Index where

import Happstack.Server
import Text.Blaze ((!))
import qualified Text.Blaze.Html4.Strict as H
import qualified Text.Blaze.Html4.Strict.Attributes as A

import HtmlHelper

-- Header --
logoDiv :: H.Html
logoDiv = H.div ! A.class_ "logo" $ do
              H.img ! A.src "img/haskell-logo.png"

titleDiv :: H.Html
titleDiv = H.div ! A.class_ "title" $ do
               H.h1 "Haskell Koans"

rightMarginDiv :: H.Html
rightMarginDiv = H.div ! A.class_ "right" $ do
                     H.p "" -- TODO: Replace with empty div

header :: H.Html
header = H.div ! A.class_ "header" $ do
             logoDiv
             titleDiv
             rightMarginDiv


-- Content --
loremBuba :: String
loremBuba = concat $ (replicate 1000 "Belly Buba ")

content :: H.Html
content = H.div ! A.class_ "content" $ do
              H.p (H.toHtml loremBuba)


-- Container --
container :: H.Html
container = H.div ! A.class_ "container" $ do
                header
                content


-- Index.html --
index :: ServerPart Response
index = 
    ok $ toResponse $
        pageBuilder "Haskell Koans"
                    [H.meta ! A.name "keywords" ! A.content "haskell, koans, programming"]
                    container
