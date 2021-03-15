#!/usr/bin/env runghc

-- run <script>

import qualified Data.PSQueue as Q
import Data.Maybe (fromJust,)

main = do
  let q = Q.insert "e" 5 $ Q.insert "d" 3 $ Q.insert "c" 1 $ Q.insert "b" 2 $ Q.insert "a" 1 Q.empty
  putStrLn $ "\nInitial queue: \n" ++ (show q)

  let (item,q') = fromJust $ Q.minView q
  putStrLn $ "\nPulling lowest-priority, earliest-inserted element:"
  putStrLn $ "\nItem: " ++ (show item)
  putStrLn $ "\nNew queue state: \n" ++ (show q')

  putStrLn $ "\nIs the queue empty? " ++ (show $ Q.null q')
