{-# LANGUAGE OverloadedStrings #-}
module Pages.Finished where

import Happstack.Server
import Text.Blaze ((!))
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

import Helpers.HtmlHelper (pageBuilder, paragraphsToP, itemsToUl)


-- Top --
emojiDiv :: H.Html
emojiDiv = H.div ! A.class_ "emoji" $ do
               H.img ! A.src "img/winner.png" 

top :: H.Html
top = H.div ! A.class_ "top" $ do
             H.h2 $ do
                "Congratulations, you finished"
                H.br 
                "the Haskell Koans!"


-- Middle --
middle :: H.Html
middle = H.div ! A.class_ "middle" $ do
             -- H.p "progress bar"
             H.form ! A.enctype "multipart/form-data" ! A.action "/" ! A.method "GET" $ do
                 H.input ! A.type_ "submit" ! A.value "Home"
                 

-- Bottom --
bottom :: H.Html
bottom = H.div ! A.class_ "bottom" $ do
             H.img ! A.src "img/haskell-logo.png"


-- Container --
container :: H.Html
container = H.div ! A.class_ "container" $ do
                emojiDiv
                top
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
