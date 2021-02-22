#!/usr/bin/env runghc

-- run <script>

main = do
  print $ let top = head $ dropWhile (\n -> (div (n*(n+1)) 2) < 100) [1..] in max (top-1) (100-(div ((top-1)*top) 2))
