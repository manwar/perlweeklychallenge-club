#!/usr/bin/env runghc

-- run <script> <difference_order> <space-separated numbers>

{-# LANGUAGE PackageImports #-}

import System.Environment (getArgs,)
import "ghc" Util (nTimes,)

main = do
  args <- getArgs
  let (ord:nrs) = map (read::String->Int) args
  print $ nTimes ord (\xs -> zipWith (-) (tail xs) xs) nrs
