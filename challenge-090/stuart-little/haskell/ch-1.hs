#!/usr/bin/env runghc

-- run as <script> <nucleobase sequence, as a string; case-insensitive>

import System.Environment   
import Data.Char
import Data.Maybe

trnsNucl s = map (fromMaybe 'x') $ map (\c -> lookup c $ zip "ATCG" "TAGC") $ map toUpper s
       
main = do  
  args <- getArgs
  let sq = args !! 0
  putStrLn $ "Sequence length: " ++ (show $ length sq)
  putStrLn $ "Complementary sequence: " ++ (trnsNucl sq)
