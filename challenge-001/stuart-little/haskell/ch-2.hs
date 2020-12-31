#!/usr/bin/env runghc

-- run as <script>

main = do  
  mapM_ putStrLn (take 20 $ map (\(a,b) -> if (b == "") then a else b) (zip (map show [1..]) (zipWith (++) (cycle $ (replicate 2 "") ++ ["fizz"] ) (cycle $ (replicate 4 "") ++ ["buzz"] ))))
