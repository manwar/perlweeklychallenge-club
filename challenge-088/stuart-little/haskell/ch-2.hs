#!/usr/bin/env runghc

-- run as <script> <nr_rows nr_columns, space-separated>

import System.Environment   
import Data.List
import Data.List.Split

pp mat = intercalate "\n" $ map unwords $ (map . map) show mat

spiral mat acc
  |null mat = acc
  |otherwise = spiral (reverse $ transpose $ tail mat) (acc ++ (head mat))

main = do
  args <- getArgs
  let rows:cols:_ = map (read::String->Int) args
      mat = chunksOf cols [1..(rows*cols)]
  putStrLn ("\nOriginal matrix:\n" ++ (pp mat) ++ "\nSpiral:\n" ++ (unwords $ map show $ spiral mat []) ++ "\n")
