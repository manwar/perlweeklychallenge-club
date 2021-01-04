#!/usr/bin/env runghc

-- run <script> <desired word-length>

import System.Environment (getArgs,)
import Data.Tree (unfoldForest,levels,)
import Data.List (isPrefixOf,)

appendAlwd w = (w, map (\c -> (w ++ [c])) $ map last $ filter (isPrefixOf $ [last w]) alwd)
  where alwd=["ae","ai","ei","ia","ie","io","iu","oa","ou","uo","ue"]
          
frst = unfoldForest appendAlwd $ map (\x -> [x]) "aeiou"

main = do
  args <- getArgs
  let lng = read (args !! 0)::Int
  mapM_ putStrLn $ concat $ map last $ map (take lng) $ map levels $ frst
