#!/usr/bin/env runghc

-- run <script> <two space-separated strings>

import Data.List.Split (split,onSublist,)
import Data.List.Utils (replace,)
import Data.Function (on,)
import System.Environment (getArgs,)
import Test.Tasty.Options (safeRead,)

zeroPad :: Int -> String -> String
zeroPad n w = (replicate (n-length w) '0') ++ w

padIfInt :: Int -> String -> String
padIfInt n w = case (safeRead::String->Maybe Int) w of
  Nothing -> w
  Just _ -> zeroPad n w

prepStringForComp :: Int -> String -> [String]
prepStringForComp n w = map (padIfInt n) $ concat . (map (split (onSublist "!"))) $ split (onSublist ".") $ replace "_" "!" w

main = do
  (s1:s2:_) <- getArgs
  let n = length s1 + length s2
  print $ (\x->x-1).fromEnum $ (compare `on` (prepStringForComp n)) s1 s2
