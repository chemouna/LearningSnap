{-# LANGUAGE OverloadedStrings #-}

module Site
  ( app
  ) where

import           Data.ByteString (ByteString)
import qualified Data.Configurator as C
import           Snap.Snaplet
import           Snap.Snaplet.Auth
import           Snap.Snaplet.Auth.Backends.JsonFile
import           Snap.Snaplet.Heist
import           Snap.Snaplet.Session.Backends.CookieSession
import           Snap.Util.FileServe
import           Control.Applicative
import           Control.Lens
import           Control.Monad.Trans
import           Data.Monoid
import           Heist
import qualified Heist.Interpreted as I
import           Snap.Core
import           Snap.Extras
import           Snap.Restful
import           Heist.Splices.BindStrict
import qualified Data.Text as T 

import           Application

data Link = Link {
                    link :: T.Text
                   }


linksH :: AppHandler ()
linksH = renderWithSplices "links" $ linksSplices

linksSplices ::  Splices (SnapletISplice App)
linksSplices = "links" ## r
  where r = I.mapSplices (I.runChildrenWith . linkSplice) [Link (T.pack "http://localhost:8000/thread_home?cateid=1"), Link (T.pack "http://localhost:8000/thread_home?cateid=2")]

linkSplice l = do
  "link" ## I.textSplice (link l)


routes :: [(ByteString, Handler App App ())]
routes  = [
            ("/links", linksH)
          , ("/", serveDirectory "static")]

app :: SnapletInit App App
app = makeSnaplet "app" "HaskellCourses application snaplet." Nothing $ do
    conf <- getSnapletUserConfig
    stpth <- liftIO (C.require conf "staticPath")
    h <- nestSnaplet "" heist $ heistInit "templates"
    s <- nestSnaplet "sess" sess $
           initCookieSessionManager "site_key.txt" "sess" (Just 3600)
    a <- nestSnaplet "auth" auth $
         initJsonFileAuthManager defAuthSettings sess (stpth ++ "/users.json")
    addRoutes routes
    addAuthSplices h auth
    return $ App h s a
