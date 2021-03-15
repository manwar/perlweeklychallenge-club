#!/usr/bin/env runghc

-- run <script>

import Data.List (transpose,)
import Data.List.Utils (countElem,)

main = do
  putStrLn $ map (head.(\l -> filter (\c -> countElem c l >= 2) l)) $ transpose grid where
    grid = ["P+2l!ato","1e80R$4u","5-r]+a>/","Pxwlb3k\\","2e35R8yu","<!r^()k0"]
