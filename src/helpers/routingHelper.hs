module Helpers.RoutingHelper
 (
   redirect,
   splitOnKeyword
) where

import Happstack.Server hiding (redirect)

-- Redirect to another URL --
redirect :: String -> ServerPart Response
redirect url = seeOther url (toResponse "")

-- splits a string into two parts (before, after) keyword
splitOnKeyword :: String -> String -> Char -> (String, String)
splitOnKeyword [] _ _               = error "couldn't find keyword on string"
splitOnKeyword (x:xs) accum keyword = if x == keyword
                                        then (accum, xs)
                                        else splitOnKeyword xs (accum ++ [x]) keyword