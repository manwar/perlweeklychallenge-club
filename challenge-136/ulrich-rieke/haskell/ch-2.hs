module Challenge136_2
  where
import Data.List ( subsequences )

fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci ( n - 2 ) + fibonacci ( n - 1 )

findFibos :: Int -> [Int]
findFibos n = drop 2 $ map fibonacci [0..n]--we drop the first 2, see the task

solution :: Int -> Int
solution n
  |elem n theFibos = 1 + ( length possibleCombis )
  |otherwise = length possibleCombis
  where
    theFibos :: [Int]
    theFibos = takeWhile ( <= n ) $ findFibos n
    theSequences :: [[Int]]
    theSequences = subsequences theFibos
    allCombis :: [[Int]]
    allCombis = foldl1 (++) $ map (\i -> filter ( (== i ) . length )
    theSequences ) [2 .. length theFibos]
    possibleCombis :: [[Int]]
    possibleCombis = filter ((== n ) . sum ) allCombis
