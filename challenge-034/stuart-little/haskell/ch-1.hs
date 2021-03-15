#!/usr/bin/env runghc

-- run <script>

import Data.List (sort,)
import System.Random (StdGen,newStdGen,randomRs,)
import System.Random.Shuffle (shuffle',)

main = do
  let l=20
  gen <- newStdGen
  let lst = shuffle' [1..l] l gen
  putStrLn $ "\nInitial list: \n" ++ (unwords $ map show lst)
  gen <- newStdGen
  let (ilow:ihigh:_) = sort $ take 2 $ randomRs (0,l-1) gen
  putStrLn $ "\nSlice between indices " ++ (show ilow) ++ " and " ++ (show ihigh) ++ ":"
  putStrLn $ unwords $ map show $ map (lst!!) [ilow..ihigh]
  
