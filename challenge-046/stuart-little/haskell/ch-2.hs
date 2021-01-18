#!/usr/bin/env runghc

-- run <script>

main = do
  print $ takeWhile (<= 500) $ map (\x->x*x) [1..] where
    n=500
