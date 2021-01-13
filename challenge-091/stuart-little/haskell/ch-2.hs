#!/usr/bin/env runghc

-- run as <script> <space-separated numbers>

import System.Environment   
import Data.List  

jmp xs
  |length xs <= 1 =True
  |(length xs >= 2) && (head xs == 0) =False
  |otherwise = jmp $ drop (head xs) xs
       
main = do  
  args <- getArgs
  putStrLn $ show $ jmp $ map (read::String->Int) args
