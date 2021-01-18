#!/usr/bin/env runghc

-- run <script>

import Data.List (nub,)

digitProds nr = map product $ map (\(i,j) -> take j $ drop i digits) idx 
  where digits = map (\x -> read [x]::Int) $ show nr
        idx = [(i,j) | i <- [0..length digits], j <- [1..length digits], i+j <= (length digits)]
          
isCol nr = let l = digitProds nr in (length l) == (length $ nub l)
       
main = do
  print $ filter isCol [100..999]
