{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TemplateHaskell #-}

module Application where

import Control.Lens
import Snap.Snaplet
import Snap.Snaplet.Heist
import Snap.Snaplet.Auth
import Snap.Snaplet.Session

-- | The application types
data App = App 
           { _heist :: Snaplet (Heist App)
            , _sess      :: Snaplet SessionManager
            , _auth      :: Snaplet (AuthManager App)
           }

makeLenses ''App

instance HasHeist App where
  heistLens = subSnaplet heist

type AppHandler = Handler App App


