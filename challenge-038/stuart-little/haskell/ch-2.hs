#!/usr/bin/env runghc

-- run <script> <path-to-dictionary-file>

import System.Random (StdGen,newStdGen,randomRs,)
import System.Environment (getArgs,)
import Data.List ((\\),lookup,)
import Data.List.Extra (maximumOn,)
import Data.Maybe (fromMaybe,)
import Data.Char (toUpper,)

canSpellWith :: String -> String -> Bool
canSpellWith basew targetw = null $ (\\) targetw basew

score :: Eq a => [(a,Int)] -> [a] -> Int
score scores wrd = sum $ map (fromMaybe 0) $ map (flip lookup scores) wrd

randomDraw :: Int -> [a] -> StdGen -> [a]
randomDraw n xs = (map (xs !!)).(take n).(randomRs (0::Int,l-1)) where
  l = length xs


main = do
  (dictpath:_) <- getArgs
  text <- readFile dictpath
  seed  <- newStdGen
  
  let scores = concat $ map (\(f,s) -> zip f (replicate (length f) s)) [("AGISUXZ", 1), ("EJLRVY", 2), ("FDPW", 3), ("BN", 4), ("TOHMC", 5), ("KQ", 10)]
      spellable = filter ((canSpellWith basew).(map toUpper)) $ words text
      basew = randomDraw 7 letters seed where
        letters = concat [(replicate 8 'A'), (replicate 3 'G'), (replicate 5 'I'), (replicate 7 'S'), (replicate 5 'U'), (replicate 2 'X'), (replicate 5 'Z'), (replicate 9 'E'), (replicate 3 'J'), (replicate 3 'L'), (replicate 3 'R'), (replicate 3 'V'), (replicate 5 'Y'), (replicate 3 'F'), (replicate 3 'D'), (replicate 5 'P'), (replicate 5 'W'), (replicate 5 'B'), (replicate 4 'N'), (replicate 5 'T'), (replicate 3 'O'), (replicate 3 'H'), (replicate 4 'M'), (replicate 4 'C'), (replicate 2 'K'), (replicate 2 'Q')]

  putStrLn $ "Your random letter choice: " ++ basew    
  putStrLn $ (\(f,s) -> f ++ " -> Score: " ++ (show s)) $ maximumOn snd $ zip spellable (map ((score scores).(map toUpper)) spellable)
