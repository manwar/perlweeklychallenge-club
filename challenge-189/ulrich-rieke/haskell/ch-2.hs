module Challenge189_2
  where
import Data.List ( sortOn )
import qualified Data.Set as S

findDegree :: [Int] -> Int
findDegree list = maximum $ map (\i -> count i list ) $ S.toList $ S.fromList list
where
  count :: Int -> [Int] -> Int
  count d li = length $ filter ( == d ) li

findSubarraysOfLength :: [Int] -> Int -> [[Int]]
findSubarraysOfLength list len = [take len $ drop i list | i <- [0..length list - len]]

findSubarrays :: [Int] -> [[Int]]
findSubarrays list = concat $ map (\i -> findSubarraysOfLength list i) [d..l]
where
  d :: Int
  d = findDegree list
  l :: Int
  l = length list

solution :: [Int] -> [Int]
solution list
  |deg == 1 = [minimum list]
  |otherwise = head $ sortOn sum $ filter ( (== deg ) . findDegree ) $ findSubarrays list
    where
    deg :: Int
    deg = findDegree list
