module Challenge125
  where
import qualified Data.Set as S
import Data.List ( sort )

--supposed to deal only with numbers up to about 20
solution :: Int -> [[Int]]
solution n = S.toList $ S.fromList $ map sort $ filter (\li -> elem n li ) $
[[ i , j , k] | i <- [1..100] , j <- [1..100] , k <- [1..100] , i ^ 2 + j ^ 2
  == k ^ 2 ]
