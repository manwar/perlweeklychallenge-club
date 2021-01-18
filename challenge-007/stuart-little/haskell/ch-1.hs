#!/usr/bin/env runghc

-- run <script>

main = do
  mapM_ print $ let digSum x = sum $ map (\d-> read [d]::Int) $ show x in (0:) $ filter (\x -> mod x (digSum x) == 0) [1..50]
