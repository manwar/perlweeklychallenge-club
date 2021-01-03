#!/usr/bin/env runghc

-- run as <script>

import System.Environment
import Data.List
       
main = do  
  let magic=[[2,7,6],[9,5,1],[4,3,8]]
  putStrLn $ intercalate "\n" $ map unwords $ (map.map) show magic
