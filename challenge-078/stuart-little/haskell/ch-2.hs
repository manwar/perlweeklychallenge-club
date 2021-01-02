#!/usr/bin/env runghc

-- run as <script>

import Data.List

rot xs ix = (snd pair) ++ (fst pair)
  where pair = splitAt ix xs
        
main = do  
  let dt = map (\p -> (map show (fst p),snd p))
        [
        ([10,20,30,40,50],[3,4]),
        ([7,4,2,6,3],[1,3,4])
        ]
  mapM_ putStrLn $ map (\s -> "\n" ++ s ++ "\n") $ map (\dtitem -> intercalate "\n" $ map unwords $ map (rot $ fst dtitem) (snd dtitem)) dt
