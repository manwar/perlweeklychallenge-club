module Challenge123_2
  where
import GHC.Float
import qualified Data.Set as S
import Data.List ( (!!) )

findDistance :: (Int, Int) -> (Int , Int) -> Double
findDistance p1 p2 = float2Double $ sqrt
((fromIntegral  ((fst p2 - fst p1) ^ 2 )) + (fromIntegral
((snd p2 - snd p1 ) ^ 2)))

allDistances :: [(Int , Int)] -> [Double]
allDistances points = map (\i -> findDistance ( points !! i )
( points !! (i + 1) ) ) [0 .. 2] ++ [findDistance ( points !! 0 )
  (points !! 3 )]

allDiagonals :: [(Int , Int)] -> [Double]
allDiagonals points = [ findDistance ( points !! 0 ) ( points !! 2 ) ,
findDistance ( points !! 1 ) ( points !! 3 ) ]

solution :: [(Int , Int)] -> Int
solution points = if myCondition then 1 else 0
where
  myCondition :: Bool
  myCondition = ((length $ S.toList $ S.fromList $ allDistances points) == 1)
  && (( length $ S.toList $ S.fromList $ allDiagonals points ) == 1)
