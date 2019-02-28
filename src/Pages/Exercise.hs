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


-- | CSS for our page
--
-- Normally this would live in an external .css file.
-- It is included inline because I'm having trouble serving the css files on build
css :: H.Html
css =
    let s = concat [".container { position: fixed; top: 0; left: 0; width: 100%; height: 100%; display: flex; flex-direction: column; background-color: #DFDFDF; } .top { padding-left: 20px; } .top h3 { font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 28px; color: #2C342D; } .middle { flex: 1; display: flex; flex-direction: column; } .middle h2 { font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 30px; color: #2C342D; text-align: center; } .middle form { flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: space-around; } .koan p { color: #808597; font-family: \"Courier New\", Courier, monospace; font-size: 22px; } .navigation { display: flex; width: 150px; justify-content: space-between; flex-direction: row-reverse; } input[type=submit] { width: 50px; height: 50px; background: rgb(73, 85, 100); border: 0 none; cursor: pointer; border-radius: 25px; color: gray; font-size : 30px } input[type=text] { margin-left: 10px; margin-right: 10px; height: 30px; border: 0 none; border-radius: 5px; color: #808597; font-family: \"Courier New\", Courier, monospace; font-size : 22px; text-align: left; padding-left: 3; } .bottom { display: flex; justify-content: flex-end; padding-right: 20px; padding-bottom: 20px; } .bottom img { width: 100px; height: 70px; } .koan { display: flex; justify-content: space-between; align-items: center; } .wrongAnswer { font-family: \"Courier New\"; font-size: 18; color: #FE0505; }"]
    in H.style ! A.type_ "text/css" $ H.toHtml s


-- exercise.html --
exercise :: (Koan, Int, Int, String) -> ServerPart Response
exercise (koan, theme, index, wrongAnswer) = 
    ok $ toResponse $
        pageBuilder "Haskell Koans"
                    [
                        H.meta ! A.name "keywords" ! A.content "haskell, koans, programming",
                        -- H.link ! A.rel "stylesheet" ! A.type_ "text/css" ! A.href "../../style/exercise.css"
                        css
                    ]
                    (container (koan, theme, index, wrongAnswer))
