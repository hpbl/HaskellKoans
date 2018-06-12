{-# LANGUAGE OverloadedStrings #-}
module HtmlHelper where

import Happstack.Server
import Text.Blaze ((!))
import qualified Text.Blaze.Html4.Strict as H
import qualified Text.Blaze.Html4.Strict.Attributes as A
import Control.Monad (msum)


pageBuilder :: String -> [H.Html] -> H.Html -> H.Html
pageBuilder title headers body =
    H.html $ do
        H.head $ do
            H.title (H.toHtml title)
            H.meta ! A.httpEquiv "content-type" ! A.content "text/html;charset=utf-8"
            H.link ! A.rel "stylesheet" ! A.type_ "text/css" ! A.href "style/index.css"
            sequence_ headers
        H.body $ do
            body