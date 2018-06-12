{-# LANGUAGE OverloadedStrings #-}
module Pages.Index where

import Happstack.Server
import Text.Blaze ((!))
import qualified Text.Blaze.Html4.Strict as H
import qualified Text.Blaze.Html4.Strict.Attributes as A

import HtmlHelper

helloBlaze :: ServerPart Response
helloBlaze = 
    ok $ toResponse $
        htmlTemplate "Hello, Blaze!"
                    [H.meta ! A.name "keywords" ! A.content "happstack, blaze, html"]
                    (H.p "This is a <p> tag")