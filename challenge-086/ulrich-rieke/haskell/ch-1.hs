module Challenge086
  where
import Data.List ( subsequences )

solution :: [Int] -> Int -> Int
solution list difference = if null difflist then 0 else 1
  where
    pairlist :: [[Int]]
    pairlist = filter ((2 ==) . length ) $ subsequences list
    difflist :: [[Int]]
    difflist = filter (\li -> abs ( head li - last li ) == difference )
    pairlist
