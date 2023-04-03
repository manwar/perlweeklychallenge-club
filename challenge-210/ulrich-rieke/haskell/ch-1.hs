module Challenge210
  where
import Data.List ( sort )
import qualified Data.Set as S

solution :: [Int] -> Int
solution list = maximum $ map (\[a , b , c] -> a * count a list + b * count b list
  + c * count c list ) $ map (\i -> [i - 1 , i , i + 1] ) uniques
  where
  uniques :: [Int]
  uniques = sort $ S.toList $ S.fromList list
  count :: Int -> [Int] -> Int
  count n l = length $ filter ( == n ) list
