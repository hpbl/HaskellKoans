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


-- | CSS for our page
--
-- Normally this would live in an external .css file.
-- It is included inline because I'm having trouble serving the css files on build
css :: H.Html
css =
    let s = concat [".container { position: fixed; top: 0; left: 0; width: 100%; height: 100%; display: flex; flex-direction: column; background-color: #DFDFDF; overflow: auto; } .emoji { display: flex; justify-content: center; padding-top: 50px; padding-bottom: 20px; } .emoji img { display: flex; width: 250; height: 163px; } .top { display: flex; justify-content: center; } .top h2 { text-align: center; font-size: 40px; color: #2C342D; font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; } .middle { flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; } .middle form { display: flex; flex-direction: column; } .navigation { display: flex; width: 150px; justify-content: space-between; } input[type=submit] { width: 150px; height: 50px; background-color: #2C342D; border: 0 none; cursor: pointer; color: #FEFEFE; border-radius: 5px; box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19); font-size : 25px; font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; } .bottom { display: flex; justify-content: flex-end; padding-right: 20px; padding-bottom: 20px; } .bottom img { width: 100px; height: 70px; }"]
    in H.style ! A.type_ "text/css" $ H.toHtml s


-- Finished.html --
finished :: ServerPart Response
finished = 
    ok $ toResponse $
        pageBuilder "Haskell Koans"
                    [
                        H.meta ! A.name "keywords" ! A.content "haskell, koans, programming",
                        -- H.link ! A.rel "stylesheet" ! A.type_ "text/css" ! A.href "style/finished.css"
                        css
                    ]
                    container
