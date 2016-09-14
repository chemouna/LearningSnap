{-# LANGUAGE TemplateHaskell #-}
module Test.ItemTest where

import Application
import Test.Hspec
import Test.Hspec.Snap
import Snap.Snaplet
import Application


itemTests :: SpecWith (SnapHspecState App)
-- itemTests = do
--   describe "ItemTest" $ do
--     describe "getAllItems" $ do
--       it "is an empty query to begin with" $ do
--         items <- Nothing
--         items `shouldEqual` [] --dummy temp test
itemTests = undefined


