#!/usr/bin/env runghc

{-
run <script> <number> <option>

<option> means 35 to convert number to base 35 or 10 to convert backwards
-}

import System.Environment (getArgs,)
import Data.List (lookup,)
import Data.Maybe (fromMaybe,)
import Data.Tuple (swap,)
import Data.Char (toUpper,)

convToListBase :: Int -> Int -> [Int]
convToListBase base nr
  |nr < base =[nr]
  |otherwise = (convToListBase base dv) ++ [md]
  where (dv,md) = divMod nr base

convFromListBase :: Int -> [Int] -> Int
convFromListBase base xs = sum $ zipWith (*) (reverse xs) $ iterate (base *) 1

numListToStr :: [(Int,Char)] -> [Int] -> String
numListToStr dict xs = map (fromMaybe '/') $ map (flip lookup dict) xs

strToNumList :: [(Int,Char)] -> String -> [Int]
strToNumList dict str = map (fromMaybe 0) $ map (flip lookup (map swap dict)) str

main = do
  (nr:opt:_) <- getArgs
  let dict = zip [0..34] (['0'..'9'] ++ ['A'..'Z'])
      res
        |opt=="35" = numListToStr dict $ convToListBase 35 (read nr::Int)
        |otherwise = show $ convFromListBase 35 $ strToNumList dict $ map toUpper nr
  putStrLn res
    
