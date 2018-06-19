{-# LANGUAGE OverloadedStrings #-}
module Pages.Exercise where

import Happstack.Server
import Text.Blaze ((!))
import qualified Text.Blaze.Html4.Strict as H
import qualified Text.Blaze.Html4.Strict.Attributes as A
import Data.Text (splitOn)

import Model.Koan (Koan, checkAnswer, codeParts, koans, intro)
import HtmlHelper (pageBuilder, paragraphsToP, marginDiv, itemsToUl)


-- Top --
top :: H.Html
top = H.div ! A.class_ "top" $ do
          H.h3 "Arithmetic Operators"
          H.p "Progress bar placeholder"


-- Middle --
navigationDiv :: H.Html
navigationDiv = H.div ! A.class_ "navigation" $ do
                    H.input ! A.type_ "submit" ! A.class_ "navButton" ! A.value "<"
                    H.input ! A.type_ "submit" ! A.class_ "navButton" ! A.value ">"

koanToHtml :: Koan -> [H.Html]
koanToHtml koan = prefix : (H.input ! A.type_ "text") : sufix : []
    where parts  = codeParts koan
          prefix = H.p (H.toHtml $ fst parts)
          sufix  = H.p (H.toHtml $ snd parts)

middle :: Koan -> H.Html
middle koan = H.div ! A.class_ "middle" $ do
                  H.form ! A.enctype "multipart/form-data" ! A.action "/input" ! A.method "POST" $ do
                      H.h2 $ H.toHtml $ intro koan -- the koan intro text
                      H.div ! A.class_ "koan" $ do
                        sequence_ $ koanToHtml koan
                      --H.input ! A.type_ "text" ! A.value "True /= " ! A.name "answer"
                      navigationDiv
                 

-- Bottom --
bottom :: H.Html
bottom = H.div ! A.class_ "bottom" $ do
             H.img ! A.src "img/haskell-logo.png"


-- Container --
container :: H.Html
container = H.div ! A.class_ "container" $ do
                top
                middle $ head koans
                bottom


-- Koans.html --
exercise :: ServerPart Response
exercise = 
    ok $ toResponse $
        pageBuilder "Haskell Koans"
                    [
                        H.meta ! A.name "keywords" ! A.content "haskell, koans, programming",
                        H.link ! A.rel "stylesheet" ! A.type_ "text/css" ! A.href "style/exercise.css"
                    ]
                    container
