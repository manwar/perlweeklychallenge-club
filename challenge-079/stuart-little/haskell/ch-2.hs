#!/usr/bin/env runghc

-- run as <script> <space-separated array entries>

import System.Environment   

holdWater a = sum $ filter ((<) 0) $ zipWith (-) (0:(map (\i -> minimum $ map maximum $ (\x -> [fst x,snd x]) $ splitAt i a) [1..(length a -1)])) a

charTr lnr val
  |val <= lnr = ' '
  |otherwise = '#'

histLine xs lnr = map (charTr lnr) xs 
hist xs = reverse $ map (histLine xs) [0..(maximum xs - 1)]

main = do  
  args <- getArgs
  let intargs = map (read::String->Int) args
  putStr "\nWater quantity: "
  putStrLn $ show $ holdWater intargs
  putStrLn "\nHistogram:\n"  
  mapM_ putStrLn $ hist intargs
