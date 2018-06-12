{-# LANGUAGE OverloadedStrings #-}
module Pages.Index where

import Happstack.Server
import Text.Blaze ((!))
import qualified Text.Blaze.Html4.Strict as H
import qualified Text.Blaze.Html4.Strict.Attributes as A

import HtmlHelper

index :: ServerPart Response
index = 
    ok $ toResponse $
        pageBuilder "Hello, Blaze!"
                    [H.meta ! A.name "keywords" ! A.content "happstack, blaze, html"]
                    header



header :: H.Html
header = H.div ! A.class_ "header" $ do
            H.p "This is a <p> tag"
            H.img ! A.class_ "logo" ! A.src "img/haskell-logo.png"