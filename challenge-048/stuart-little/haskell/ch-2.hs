#!/usr/bin/env runghc

-- run <script>

import Data.List (sortOn,)
import Data.Tuple (swap,)
import Text.Printf (printf,)

main = do
  mapM_ putStrLn $ sortOn (swap.(splitAt 4)) $ map (\[x,y]-> x ++ y ++ (reverse y) ++ (reverse x)) $ sequence [(map (printf "%02d") ([1..12]::[Int])),["02","12","22"]]
