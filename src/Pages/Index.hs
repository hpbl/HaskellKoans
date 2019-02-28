{-# LANGUAGE OverloadedStrings #-}
module Pages.Index where

import Happstack.Server
import Text.Blaze ((!))
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

import Helpers.HtmlHelper (pageBuilder, paragraphsToP, marginDiv, itemsToUl)
import Model.KoanManager (themes)

-- Header --
logoDiv :: H.Html
logoDiv = H.div ! A.class_ "logo" $ do
              H.img ! A.src "img/haskell-logo.png"

titleDiv :: H.Html
titleDiv = H.div ! A.class_ "title" $ do
               H.h1 "Haskell Koans"

header :: H.Html
header = H.div ! A.class_ "header" $ do
             logoDiv
             titleDiv
             marginDiv


-- Content --
introParagraphs :: [String]
introParagraphs = [
        "Haskell /ˈhæskəl/ is a standardized, general-purpose compiled purely functional programming language, with non-strict semantics and strong static typing. It is named after logician Haskell Curry.",
        "Haskell koans is the beginning of your journey towards Functional Enlightenment. By reflecting on each Koan you will lear about the mysterious ways of this amazing language. Every Koan contains a helpful message along with a line of code. As you will notice, the code is incomplete, and only you can make it whole again. So take deep breath, grab a cup of your favorite tea, and let us begin!"
    ]

introTextDiv :: H.Html
introTextDiv = H.div ! A.class_ "introText" $ do
               sequence_ $ paragraphsToP introParagraphs
               itemsToUl themes
               H.form ! A.enctype "multipart/form-data" ! A.action "/koans/0/0" ! A.method "GET" $ do
                   H.button ! A.class_ "start" $ "Let's Start!"

content :: H.Html
content = H.div ! A.class_ "content" $ do
              marginDiv
              introTextDiv
              marginDiv


-- Container --
container :: H.Html
container = H.div ! A.class_ "container" $ do
                header
                content


-- | CSS for our site
--
-- Normally this would live in an external .css file.
-- It is included inline here to keep the example self-contained.
css :: H.Html
css =
    let s = concat [".container { position: fixed; top: 0; left: 0; width: 100%; height: 100%; display: flex; flex-direction: column; background-color: #DFDFDF; overflow: auto; } .header { display: flex; flex-direction: row; justify-content: flex-start; padding-top: 20px; } .title { flex: 1; display: flex; justify-content: center; align-items: center; font-size: 30px; font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; color: #2C342D; } .logo { flex: 1; display: flex; justify-content: center; } .logo img { margin-right: 100px; width: 100px; height: 70px; } .margin { flex: 1; } .content { flex: 1; display: flex; justify-content: center; } .introText { flex: 3; padding-left: 10px; padding-right: 10px; display: flex; flex-direction: column; } .introText p { text-align: justify; font-size: 22px; color: #404040; font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; } .introText ul li { /* .introText ul li a*/ margin-bottom: 10px; text-align: justify; font-size: 22px; color: #404040; font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; } .introText .start { align-self: flex-end; width:150px; height:75px; background-color: #2C342D; font-size: 25px; color: #FEFEFE; border-radius: 12px; box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19); cursor: pointer; font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; } .introText form { display: flex; justify-content: flex-end; }"]
    in H.style ! A.type_ "text/css" $ H.toHtml s


-- Index.html --
index :: ServerPart Response
index = 
    ok $ toResponse $
        pageBuilder "Haskell Koans"
                    [
                        H.meta ! A.name "keywords" ! A.content "haskell, koans, programming",
                        -- H.link ! A.rel "stylesheet" ! A.type_ "text/css" ! A.href "style/index.css"
                        css
                    ]
                    container
