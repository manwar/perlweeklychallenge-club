#!/usr/bin/env runghc

-- run <script> <number>

import System.Environment (getArgs,)

main = do
  (nr:_) <- getArgs
  let nrint = read nr::Int
  mapM_ putStrLn $ map (\(p:q:_) -> (show p) ++ "^" ++ (show q)) $ filter (\(p:q:_) -> p ^ q == nrint) $ sequence $ replicate 2 [2..(floor $ sqrt $ fromIntegral nrint)]
