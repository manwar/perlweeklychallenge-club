module Challenge201_2
  where
import qualified Data.Set as S

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] ,
x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]

--a list that contains all numbers from 1 to n as often as necessary to sum up to n
allNumberCombis :: Int -> [Int]
allNumberCombis n = concat $ map (\i -> replicate ( div n i ) i ) [1..n]

--create all combinations of 2 to n - 1 elements , consider every list only once
--by making a transitional set of them, and add 2 to take n times 1 and 1 times n
--into account
solution :: Int -> Int
solution n = length (filter ( (== n ) . sum ) $ S.toList $ S.fromList $ concat $ map
(\i -> combinations i theCombis ) [2..n - 1]) + 2
where
  theCombis :: [Int]
  theCombis = allNumberCombis n
