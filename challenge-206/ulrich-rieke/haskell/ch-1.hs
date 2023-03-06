module Challenge206
  where
import Data.List( permutations , (!!) )
import Data.List.Split ( divvy , splitOn )

findTimeValue :: String -> Int
findTimeValue aTime = (list !! 0 ) * 60 + list !! 1
where
  list :: [Int]
  list = map read $ splitOn ":" aTime

findTimeDifference :: String -> String -> Int
findTimeDifference timeA timeB
  |diff < 0 = timePointB + 24 * 60 - timePointA
  |otherwise = diff
  where
    timePointB :: Int
    timePointB = findTimeValue timeB
    timePointA :: Int
    timePointA = findTimeValue timeA
    diff      :: Int
    diff      = timePointB - timePointA

solution :: [String] -> Int
solution timestrings = minimum $ map (\li -> findTimeDifference ( last li ) ( head li ) )
  $ concat $ map (\subli -> divvy 2 1 subli ) $ permutations timestrings
