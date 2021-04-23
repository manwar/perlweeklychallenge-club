#!/usr/bin/env runghc

-- run <script>

import Data.List.Utils (join)
import System.Environment (getArgs)
import Text.Printf (printf)

fst3 :: [(Int, (Int,Int))]
fst3 = [(100,(4,1210)),(136,(4,2020)),(1425,(5,21200))]

fmt :: (Int,(Int,Int)) -> String
fmt (nr,(b,nrb)) = printf "Base 10: %d\nBase %d: %d" nr b nrb

main = do
  putStrLn $ join "\n\n" $ map fmt fst3
