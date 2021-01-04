#!/usr/bin/env runghc

-- run as <script>
   
import Data.List (intercalate,)
import Data.Tree (Tree(Node),flatten,drawTree,)

main = do  
  let dt = [
        (Node 1 [Node 2 [], Node 3 [Node 4 []]]),        
        (Node 1 [Node 2 [Node 4 [], Node 5 [Node 6 [], Node 7 []]], Node 3 []])        
           ]
  mapM_ putStrLn $ map (\t -> ("Tree:\n" ++ (drawTree $ fmap show t) ++ "\nList: " ++ (intercalate "->" $ map show $ flatten t) ++ "\n" ++ (replicate 40 '-'))) dt
