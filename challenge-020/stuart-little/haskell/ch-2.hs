#!/usr/bin/env runghc

-- run <script>

import Math.NumberTheory.ArithmeticFunctions (sigma,)

main = do
  print $ let f x = sigma 1 x -x; ls = [(2::Int)..] in head $ dropWhile (\(x,y) -> x == y || f y /= x) $ zip ls $ map f ls
