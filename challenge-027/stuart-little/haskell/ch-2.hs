#!/usr/bin/env runghc

{-
run <script> and keep entering integer values
-}

import Data.List.Extra (headDef,)

mn :: [Int] -> IO ()
mn xs = do
  putStrLn $ "Last value: " ++ (headDef "none yet" $ map show xs)
  putStrLn $ "History: " ++ (show xs)
  x <- (readLn::IO Int)
  mn (x:xs)

main :: IO ()
main = mn []
