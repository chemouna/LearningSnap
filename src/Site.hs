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


import           Control.Monad.Trans

import           Heist
import qualified Heist.Interpreted as I
import           Snap.Core



import qualified Data.Text as T
-- import Text.XmlHtml

import           Application

data Link = Link {
                    linkId :: Integer
                   }


linksH :: AppHandler ()
linksH = method GET (renderWithSplices "links" linksSplices)

linksSplices ::  Splices (SnapletISplice App)
linksSplices = "links" ## r
  where r = I.mapSplices (I.runChildrenWith . linkSplice) [Link 1, Link 2]

linkSplice :: Monad n => Link -> Splices (I.Splice n)
linkSplice l = do
  "link_id" ## I.textSplice (T.pack (show (linkId l)))

routes :: String -> [(ByteString, AppHandler ())]
routes stpth = [
            ("/links", linksH)
          , ("/store", serveDirectory (stpth ++ "/store"))
          , ("/",      serveDirectory "static")]

app :: SnapletInit App App
app = makeSnaplet "app" "HaskellCourses application snaplet." Nothing $ do
    conf <- getSnapletUserConfig
    stpth <- liftIO (C.require conf "staticPath")
    h <- nestSnaplet "" heist $ heistInit "templates"
    s <- nestSnaplet "sess" sess $
           initCookieSessionManager "site_key.txt" "sess" (Just 3600)
    a <- nestSnaplet "auth" auth $
         initJsonFileAuthManager defAuthSettings sess (stpth ++ "/users.json")
    addRoutes (routes stpth)
    addAuthSplices h auth
    return $ App h s a
