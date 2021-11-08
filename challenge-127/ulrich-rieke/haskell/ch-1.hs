module Challenge127
  where
import qualified Data.Set as S

solution :: [Int] -> [Int] -> Int
solution firstList secondList
  |S.null $ S.intersection ( S.fromList firstList ) ( S.fromList secondList ) = 1
  |otherwise                                                                  = 0
