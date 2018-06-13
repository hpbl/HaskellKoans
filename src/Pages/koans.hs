{-# LANGUAGE OverloadedStrings #-}
module Pages.Koans where

import Happstack.Server
import Text.Blaze ((!))
import qualified Text.Blaze.Html4.Strict as H
import qualified Text.Blaze.Html4.Strict.Attributes as A

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

middle :: H.Html
middle = H.div ! A.class_ "middle" $ do
             H.form ! A.enctype "multipart/form-data" ! A.action "/input" ! A.method "POST" $ do
                 H.h2 "Make it True"
                 H.input ! A.type_ "text" ! A.value "True /= " ! A.name "answer"
                 navigationDiv
                 

-- Bottom --
bottom :: H.Html
bottom = H.div ! A.class_ "bottom" $ do
             H.img ! A.src "img/haskell-logo.png"


-- Container --
container :: H.Html
container = H.div ! A.class_ "container" $ do
                top
                middle
                bottom


-- Koans.html --
koans :: ServerPart Response
koans = 
    ok $ toResponse $
        pageBuilder "Haskell Koans"
                    [
                        H.meta ! A.name "keywords" ! A.content "haskell, koans, programming",
                        H.link ! A.rel "stylesheet" ! A.type_ "text/css" ! A.href "style/koans.css"
                    ]
                    container
