{-# LANGUAGE OverloadedStrings #-}
module Pages.Exercise where

import Happstack.Server
import Text.Blaze ((!))
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import Data.String (fromString)

import Model.Koan (Koan, codeParts, intro)
import Helpers.HtmlHelper (pageBuilder, paragraphsToP, marginDiv, itemsToUl)


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

koanDiv :: (Koan, Int) -> H.Html
koanDiv (koan, index) = H.div ! A.class_ "koan" $ do
                            prefix 
                            H.input ! A.type_ "text" ! A.name "answer" ! A.autocomplete "off"
                            H.input ! A.type_ "hidden" ! A.name "koanNumber" ! A.value (fromString (show index))
                            sufix
            where parts  = codeParts koan
                  prefix = H.p (H.toHtml $ fst parts)
                  sufix  = H.p (H.toHtml $ snd parts)

middle :: (Koan, Int) -> H.Html
middle (koan, index) = H.div ! A.class_ "middle" $ do
                        H.form ! A.enctype "multipart/form-data" ! A.method "POST" $ do
                            H.h2 (H.toHtml $ intro koan) -- the koan intro text
                            koanDiv (koan, index)
                            navigationDiv
                 

-- Bottom --
bottom :: H.Html
bottom = H.div ! A.class_ "bottom" $ do
             H.img ! A.src "../img/haskell-logo.png"


-- Container --
container :: (Koan, Int) -> H.Html
container (koan, index) = H.div ! A.class_ "container" $ do
                            top
                            (middle (koan, index))
                            bottom


-- exercise.html --
exercise :: (Koan, Int) -> ServerPart Response
exercise (koan, index) = 
    ok $ toResponse $
        pageBuilder "Haskell Koans"
                    [
                        H.meta ! A.name "keywords" ! A.content "haskell, koans, programming",
                        H.link ! A.rel "stylesheet" ! A.type_ "text/css" ! A.href "../style/exercise.css"
                    ]
                    (container (koan, index))
