module Challenge054
  where
import Data.List( permutations , (!!) )

solution :: Int -> Int -> [ Int ]
solution listlen permus
  |length permutis < permus = []
  |otherwise = permutis !! permus
  where
      permutis = permutations [1..listlen]
