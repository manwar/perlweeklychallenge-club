#!/usr/bin/env runghc

-- run as <script> <number>

import System.Environment   
import Data.List

gcdSum nr = sum $ map (\x -> gcd (fst x) (snd x)) [(x,y) | x <- [1..nr], y <- [x+1..nr]]
       
main = do  
  args <- getArgs
  putStrLn $ show $ gcdSum $ (read::String->Int) $ args !! 0
