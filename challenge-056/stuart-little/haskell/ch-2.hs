#!/usr/bin/env runghc

-- run as <script>

import Data.Tree (Tree(Node), foldTree, drawTree)
import Data.List (intercalate)

maxPaths t = foldTree addHeadToPaths t
  where
    addHeadToPaths x [] = [[x]]
    addHeadToPaths x xs = concat $ (map.map) (x:) xs

pp (val,t) = "Initial tree:\n\n" ++
  (drawTree $ fmap show t) ++
  "\nValue to search for: " ++
  (show val) ++
  "\n" ++
  "\nPaths that give the target sum: \n" ++
  (intercalate "\n" $ map unwords $ (map.map) show $ filter (\xs -> sum xs == val) $ maxPaths t) ++
  ("\n" ++ replicate 40 '-')
             
main = do
  let dt = [
        (7,(Node 1 [Node 2 [Node 3 [], Node 4 []]])),
        (27,(Node 1 [Node 2 [Node 4 []], Node 3 [Node 5 [], Node 6 []]])),
        (22,(Node 5 [Node 4 [Node 11 [Node 7 [], Node 2 []]], Node 8 [Node 13 [], Node 9 [Node 1 []]]]))
              ]
  mapM_ putStrLn $ map pp dt
