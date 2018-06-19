module Helpers.RoutingHelper
 (
   redirect
) where

import Happstack.Server hiding (redirect)

-- Redirect to another URL --
redirect :: String -> ServerPart Response
redirect url = seeOther url (toResponse "")