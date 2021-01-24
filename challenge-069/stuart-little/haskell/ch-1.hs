#!/usr/bin/env runghc

-- run <script> <lower bound> <upper bound>

import Data.List (sort,(\\),)
import Data.List.Utils (replace,)
import System.Environment (getArgs,)

nrDig :: Integer -> Int
nrDig x = ceiling $ logBase 10 $ fromIntegral $ x+1

alph :: String
alph = "01689"

strobHalf :: Int -> [String]
strobHalf n
  |n<=1 = sequence [alph]
  |even n = sequence $ (alph \\ "0"):(replicate (div n 2 -1) alph)
  |odd n = sequence $ ((alph \\ "0"):(replicate (div n 2 -1) alph)) ++ [alph \\ "69"]     

strob :: Int -> [String]
strob n = map (\x -> x ++ rfl n x) $ strobHalf n where
  rfl :: Int -> String -> String
  rfl n s = replace "#" "9" $ replace "9" "6" $ replace "6" "#" $ reverse $ take (div n 2) s

strobBds :: Integer -> Integer -> [String]
strobBds low high = filter (\s -> rd s >= low && rd s <= high) $ concat $ map strob [(nrDig low)..(nrDig high)] where
  rd = (read::String->Integer)

main = do
  (low:high:_) <- getArgs >>= return.sort.(map (read::String->Integer))
  putStrLn $ unwords $ strobBds low high
