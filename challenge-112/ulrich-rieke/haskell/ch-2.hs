module Challenge112
  where
import Data.List ( permutations , nub )

stepcounter :: Int -> Int
stepcounter n =  length $ concat $ map (nub . permutations)  [ replicate t 1 ++
  replicate o 2 | t <- [0 .. n] , o <- [0 .. div n 2] , sum ( replicate t 1 ++
  replicate o 2  ) == n]
