#!/usr/bin/env runghc

-- run <script>

{-# LANGUAGE DataKinds #-}

import Numeric.Rounded (RoundingMode( TowardZero ), Rounded,)
import Data.List.Index (insertAt,)
import Data.List (delete,)

main = do
  putStrLn $ insertAt 18 '.' $ delete '.' $ take 70 $ show (exp $ pi * sqrt 163 :: Rounded TowardZero 1000)
