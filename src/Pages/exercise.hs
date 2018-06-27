{-# LANGUAGE OverloadedStrings #-}
module Pages.Exercise where

import Happstack.Server
import Text.Blaze ((!))
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import Data.String (fromString)

import Model.Koan (Koan, codeParts, intro, theme, answer)
import Helpers.HtmlHelper (pageBuilder, paragraphsToP, marginDiv, itemsToUl)


-- Top --
top :: Koan -> H.Html
top koan = H.div ! A.class_ "top" $ do
            H.h3 $ H.toHtml $ theme koan
            --H.p "Progress bar placeholder"


-- Middle --
navigationDiv :: H.Html
navigationDiv = H.div ! A.class_ "navigation" $ do
                    H.input ! A.type_ "submit" ! A.class_ "navButton" ! A.value ">" ! A.name "forward"
                    H.input ! A.type_ "submit" ! A.class_ "navButton" ! A.value "<" ! A.name "back" 


koanDiv :: (Koan, Int, Int) -> H.Html
koanDiv (koan, theme, index) = H.div ! A.class_ "koan" $ do
                            prefix 
                            H.input ! A.type_ "text" ! A.name "answer" ! A.autocomplete "off" ! A.size (fromString $ show $ length $ answer koan)
                            H.input ! A.type_ "hidden" ! A.name "koanNumber" ! A.value (fromString (show index))
                            H.input ! A.type_ "hidden" ! A.name "themeNumber" ! A.value (fromString (show theme))
                            sufix
            where parts  = codeParts koan
                  prefix = H.p (H.toHtml $ fst parts)
                  sufix  = H.p (H.toHtml $ snd parts)

middle :: (Koan, Int, Int, String) -> H.Html
middle (koan, theme, index, wrongAnswer) = H.div ! A.class_ "middle" $ do
                                            H.form ! A.enctype "multipart/form-data" ! A.method "POST" $ do
                                                H.h2 (H.toHtml $ intro koan) -- the koan intro text
                                                koanDiv (koan, theme, index)
                                                H.p (H.toHtml wrongAnswer) ! A.class_ "wrongAnswer"
                                                navigationDiv
                 

-- Bottom --
bottom :: H.Html
bottom = H.div ! A.class_ "bottom" $ do
             H.img ! A.src "../../img/haskell-logo.png"


-- Container --
container :: (Koan, Int, Int, String) -> H.Html
container (koan, theme, index, wrongAnswer) = H.div ! A.class_ "container" $ do
                                                (top koan)
                                                (middle (koan, theme, index, wrongAnswer))
                                                bottom


-- exercise.html --
exercise :: (Koan, Int, Int, String) -> ServerPart Response
exercise (koan, theme, index, wrongAnswer) = 
    ok $ toResponse $
        pageBuilder "Haskell Koans"
                    [
                        H.meta ! A.name "keywords" ! A.content "haskell, koans, programming",
                        H.link ! A.rel "stylesheet" ! A.type_ "text/css" ! A.href "../../style/exercise.css"
                    ]
                    (container (koan, theme, index, wrongAnswer))
