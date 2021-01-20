#!/usr/bin/env runghc

-- run <script> <'-e' or '-d' flag tencode or decode respectively> <keyword> <quoted text>

{-# LANGUAGE PackageImports #-}

import Data.Char (toUpper,ord,chr,)
import System.Environment (getArgs,)
import "ghc" Util (nTimes,)

alph :: String
alph = ['A'..'Z']

baseOffset :: Int
baseOffset = ord 'A'

norm :: String -> String
norm = (filter (flip elem alph)) . (map toUpper)

vigEncode :: String -> String -> String
vigEncode key input = map (\(o,c) -> chr $ baseOffset + (mod (ord c -baseOffset +o) (length alph))) $ zip offsets $ norm input where
  offsets = map ((flip (-) baseOffset) . ord) $ cycle $ norm key

vigDecode :: String -> String -> String
vigDecode key = nTimes (length alph -1) (vigEncode key)

main = do
  (flag:key:txt:_) <- getArgs
  let process = if flag == "-d" then vigDecode else vigEncode
  putStrLn $ process key txt
