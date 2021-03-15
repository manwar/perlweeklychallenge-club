#!/usr/bin/env runghc

{-
run <script>
    <flag: -e for encryption and -d for decryption>
    <input: quoted text for encryption or space-separated integers for decryption>
-}

import Data.Char (toUpper)
import Data.List (elemIndex,(\\),inits,foldl')
import Data.Maybe (fromJust)
import Data.Map.Strict (Map)
import System.Environment (getArgs,)
import qualified Data.Map.Strict as M

alph :: [String]
alph = sequence [('#':['A'..'Z'])]

alphMap :: Map Int String
alphMap = M.fromAscList $ zip [0..] alph

lzwEnc :: [String] -> String -> [Int]
lzwEnc alph str
  |null str = []
  |str == "#" = [0]
  |otherwise = (c:cs) where
     longestRec = last $ takeWhile (flip elem alph) $ tail $ inits str
     rest = str \\ longestRec
     new = longestRec ++ [head rest]
     c = fromJust $ elemIndex longestRec alph     
     cs = lzwEnc (alph ++ [new]) rest

lzwDec1 :: ([a],Map Int [a]) -> (Int,Int) -> ([a],Map Int [a])
lzwDec1 (s,m) (x,y)
  |y == sz = ((s++new),M.insert sz new m)
  |otherwise = ((s++curr),M.insert sz (prev ++ [head curr]) m) where
     sz = M.size m
     prev = m M.! x
     curr = m M.! y
     new =  prev ++ [head prev]

lzwDec :: Map Int String -> [Int] -> String
lzwDec _ [] = ""
lzwDec m ls@(x:xs) = fst $ foldl' lzwDec1 (m M.! x, m) $ zip ls xs

main = do
  (flag:rest) <- getArgs
  putStrLn $ if flag == "-e"
             then unwords $ map show $ lzwEnc alph $ filter (flip elem $ concat $ tail alph) $ map toUpper $ head rest
             else lzwDec alphMap $ map (read::String->Int) rest
