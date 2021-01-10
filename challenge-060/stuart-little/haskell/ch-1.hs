#!/usr/bin/env runghc

-- run <script> <number or column name>

import System.Environment (getArgs,)
import Data.Char (toUpper,)

alph = map (\x -> [x]) ['A'..'Z']
excel = concat $ map (\nr -> map concat $ sequence $ replicate nr alph) [1..]

main = do
  args <- getArgs
  let inpt = map toUpper (args !! 0)
  putStrLn $ unwords $ head $ dropWhile (notElem inpt) $ zipWith (\x y -> [x,y]) (map show [1..]) excel
