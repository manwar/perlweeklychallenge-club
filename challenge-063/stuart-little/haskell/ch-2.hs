#!/usr/bin/env runghc

-- run <script> <x-y_string>

import System.Environment (getArgs,)

rot n xs = right ++ left where
  (left,right) = splitAt (mod n $ length xs) xs

main = do
  args <- getArgs
  let wrd = args !! 0
  print $ head $ dropWhile (\n -> wrd /= rot (div (n*(n+1)) 2) wrd) [1..]
