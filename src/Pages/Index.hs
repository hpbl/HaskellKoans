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


-- Index.html --
index :: ServerPart Response
index = 
    ok $ toResponse $
        pageBuilder "Haskell Koans"
                    [
                        H.meta ! A.name "keywords" ! A.content "haskell, koans, programming",
                        H.link ! A.rel "stylesheet" ! A.type_ "text/css" ! A.href "style/index.css"
                    ]
                    container
