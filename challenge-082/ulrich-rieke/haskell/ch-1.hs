module Challenge082
  where
import qualified Data.Set as S

divisors :: Int -> [Int]
divisors n = [ d | d <- [1..n] , mod n d == 0 ]

solution ::Int -> Int -> [Int]
solution a b = S.toList ( (S.fromList $ divisors a) `S.intersection`
      (S.fromList $ divisors b ) )
