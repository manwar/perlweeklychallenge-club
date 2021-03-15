#!/usr/bin/env runghc

-- run <script>

import Data.List (transpose,nub,)

main = do
  putStrLn ((show root) ++ " squares to " ++ (show sq)) where
    (root,sq) = head $ dropWhile ((4 >=).length.(\x -> nub $ transpose [x] ).show.snd) $ zip [1..] $ map (\x -> x*x) [1..]
