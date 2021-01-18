#!/usr/bin/env runghc

-- run <script> <digit_string>

import System.Environment (getArgs,)
import Data.Maybe (fromMaybe,)

combos :: Eq a => [a] -> [(a,[b])] -> [[b]]
combos as dict = sequence $ map (fromMaybe []) $ map (flip lookup dict) as

main = do
  (nr:_) <- getArgs
  let dict = zip ['1'..'9'] ["_@","abc","def","ghi","jkl","mno","pqrs","tuv","wxyz"]
  putStrLn $unwords $ combos nr dict
