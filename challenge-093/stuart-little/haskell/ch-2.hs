#!/usr/bin/env runghc

-- run as <script>

import Data.Tree (Tree(Node), foldTree, drawTree)

maxPaths t = foldTree addHeadToPaths t
  where
    addHeadToPaths x [] = [[x]]
    addHeadToPaths x xs = concat $ (map.map) (x:) xs

sumPaths t = sum $ map sum $ maxPaths t

pp t = "Initial tree:\n\n" ++ (drawTree $ fmap show t) ++ "\nSum of all path sums: " ++ (show $ sumPaths t) ++ "\n" ++ (replicate 40 '-')
             
main = do
  let trees = [
        (Node 1 [Node 2 [Node 3 [], Node 4 []]]),
        (Node 1 [Node 2 [Node 4 []], Node 3 [Node 5 [], Node 6 []]])
              ]
  mapM_ putStrLn $ map pp trees
