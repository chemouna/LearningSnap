module Spec  where

import Control.Monad
import Site
import Snap (route)
import Test.Hspec
import Test.Hspec.Snap
import Helper
import ItemTest

main :: IO ()
main = hspec $ snap (route routes) testApp $ do
  afterEval (void clearDb) $ do
    itemTests


