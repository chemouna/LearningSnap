{-# LANGUAGE OverloadedStrings #-}

module Helper
       ( testApp
       -- , clearDb
       ) where

import           Application
import           Control.Monad.IO.Class
import qualified Data.Configurator as C
-- import           Database.PostgreSQL.Simple
import           Snap.Snaplet
import           Snap.Snaplet.Auth
import           Snap.Snaplet.Auth.Backends.JsonFile
import           Snap.Snaplet.Heist
import           Snap.Snaplet.Session.Backends.CookieSession

testApp :: SnapletInit App App
testApp = makeSnaplet "app" "Test application." Nothing $ do
  conf <- getSnapletUserConfig
  stpth <- liftIO (C.require conf "staticPath")
  h <- nestSnaplet "" heist $ heistInit "templates"
  s <- nestSnaplet "sess" sess $ initCookieSessionManager "site_key.txt" "sess" (Just 3600)
  a <- nestSnaplet "auth" auth $ initJsonFileAuthManager defAuthSettings sess (stpth ++ "/users.json ")
  addAuthSplices h auth
  return $ App h s a


-- clearDb :: Handler App App ()
-- clearDb = do
--   _ <- execute "delete from video" ()
--   _ <- execute "delete from category" ()
--   _ <- execute "delete from config" ()
--   return ()
