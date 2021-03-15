#!/usr/bin/env runghc

-- run <script>

main = do
  putStrLn ((show x) ++ " F = " ++ (show x) ++ " C") where
    x = (-32)*5/4
