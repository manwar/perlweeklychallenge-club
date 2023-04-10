module Challenge211
  where
import Data.List ( (!!) )

isToeplitz :: [[Int]] -> Bool
isToeplitz list = allSame $ map (\p -> ( snd p ) !! ( fst p ) )
  $ zip [0..length list - 1] list
  where
  allSame :: [Int] -> Bool
  allSame aList = all (\n -> n == ( head aList ) ) aList
