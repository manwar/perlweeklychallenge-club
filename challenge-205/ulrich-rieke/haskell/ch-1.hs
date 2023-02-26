module Challenge205
  where
import qualified Data.Set as S
import Data.List ( sort )

solution :: [Int] -> Int
solution list
  |length uniques < 3 = maximum uniques
  |otherwise = head $ drop ( l - 3 ) $ sort uniques
  where
    uniques :: [Int]
    uniques = S.toList $ S.fromList list
    l      :: Int
    l      = length uniques
