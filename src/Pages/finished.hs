{-# LANGUAGE OverloadedStrings #-}
module Pages.Finished where

import Happstack.Server
import Text.Blaze ((!))
import qualified Text.Blaze.Html4.Strict as H
import qualified Text.Blaze.Html4.Strict.Attributes as A

import Helpers.HtmlHelper (pageBuilder, paragraphsToP, marginDiv, itemsToUl)


-- Middle --
middle :: H.Html
middle = H.div ! A.class_ "middle" $ do
             H.h1 "Congratulations, you finished the Haskell Koans!"
             H.p "progress bar"
             H.form ! A.enctype "multipart/form-data" ! A.action "/" ! A.method "GET" $ do
                 H.input ! A.type_ "submit" ! A.value "Home"
                 

-- Bottom --
bottom :: H.Html
bottom = H.div ! A.class_ "bottom" $ do
             H.img ! A.src "img/haskell-logo.png"


-- Container --
container :: H.Html
container = H.div ! A.class_ "container" $ do
                marginDiv
                middle
                bottom


-- Finished.html --
finished :: ServerPart Response
finished = 
    ok $ toResponse $
        pageBuilder "Haskell Koans"
                    [
                        H.meta ! A.name "keywords" ! A.content "haskell, koans, programming",
                        H.link ! A.rel "stylesheet" ! A.type_ "text/css" ! A.href "style/finished.css"
                    ]
                    container
