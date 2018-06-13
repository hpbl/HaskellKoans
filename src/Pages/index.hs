{-# LANGUAGE OverloadedStrings #-}
module Pages.Index where

import Happstack.Server
import Text.Blaze ((!))
import qualified Text.Blaze.Html4.Strict as H
import qualified Text.Blaze.Html4.Strict.Attributes as A

import HtmlHelper (pageBuilder, paragraphsToP, marginDiv, itemsToUl)

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
        "Haskell features lazy evaluation, pattern matching, list comprehension, type classes and type polymorphism. It is a purely functional language, which means that functions generally have no side effects. A distinct construct exists to represent side effects, orthogonal to the type of functions. A pure function can return a side effect that is subsequently executed, modeling the impure functions of other languages."
    ]

subjects :: [String]
subjects = ["Syntax", "Operators", "Lists", "Functions"]

introTextDiv :: H.Html
introTextDiv = H.div ! A.class_ "introText" $ do
               sequence_ $ paragraphsToP introParagraphs
               itemsToUl subjects
               H.form ! A.enctype "multipart/form-data" ! A.action "/koans" ! A.method "GET" $ do
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
