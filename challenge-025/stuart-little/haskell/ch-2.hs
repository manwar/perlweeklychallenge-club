#!/usr/bin/env runghc

{-
run <script>
    <optional flag: -e to encrypt and -d to decrypt, defaulting to encryption if passed nothing>
    <quoted text>

If you want to alter your initial cipher and plain alphabets ("left" and "right" respectively, in Byrne's twrminology) modify ciAlph and plAlph below.

You can double check the script output at [0].

References:

[0] https://www.dcode.fr/chao-cipher
-}

{-# LANGUAGE PackageImports #-}

import Data.Char (toUpper)
import Data.List (elemIndex)
import Data.Maybe (fromJust)
import System.Environment (getArgs)
import "ghc" Util (nTimes)

data ChaoCipher = CC { ciAlph :: String
                     , plAlph :: String
                     } deriving (Show)

cc :: ChaoCipher
cc = CC { ciAlph="HXUCZVAMDSLKPEFJRIGTWOBNYQ"
        , plAlph="PTLNBQDEOYSFAVZKGJRIHWXUMC"
        }

rotAt :: Int -> Int -> [a] -> [a]
rotAt i n xs = let (as,(bs,cs)) = (\(ps,qs) -> (ps,splitAt n qs)) $ splitAt i $ cycle xs in
  take (length xs) $ as ++ (tail bs ++ [head bs]) ++ cs

rotGl :: [a] -> [a]
rotGl xs = rotAt 0 (length xs) xs

ccStep :: Int -> ChaoCipher -> ChaoCipher
ccStep n (CC lAlph rAlph) = CC l r where
  l = rotAt 1 13 $ nTimes n rotGl lAlph
  r = rotAt 2 12 $ nTimes (n+1) rotGl rAlph

ccEnc1 :: Char -> (String,ChaoCipher) -> (String,ChaoCipher)
ccEnc1 c (s,cc) = ((ciAlph cc !! i):s, ccStep i cc) where
  i = fromJust $ elemIndex c $ plAlph cc

ccDec1 :: Char -> (String,ChaoCipher) -> (String,ChaoCipher)
ccDec1 c (s,cc) = ((plAlph cc !! i):s, ccStep i cc) where
  i = fromJust $ elemIndex c $ ciAlph cc

main = do
  args <- getArgs
  let (flag,txt)
        |h == "-e" = ("encode", head $ tail args)
        |h == "-d" = ("decode", head $ tail args)
        |otherwise = ("encode", h) where
           h = head args
      prcs = if flag=="decode"
           then ccDec1
           else ccEnc1
  putStrLn $ reverse $ fst $ foldr prcs ("",cc) $ reverse $ filter (flip elem ['A'..'Z']) $ map toUpper txt
    
