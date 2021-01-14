#!/usr/bin/env runghc

-- run <script> <nr of digits you want to see>

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE ScopedTypeVariables #-}

import System.Environment (getArgs,)
import Numeric.Rounded (RoundingMode( TowardZero ), Rounded,reifyPrecision,)
import Data.Proxy (Proxy,)

main = do
  nrdig <- getArgs >>= return.(read::String->Int).head
  putStrLn $ reifyPrecision (4*nrdig) (\(_ :: Proxy p) -> take (nrdig+1) $ show (exp 1 :: Rounded TowardZero p))
