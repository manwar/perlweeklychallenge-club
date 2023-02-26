module Challenge205_2
  where
import Data.Bits ( xor )
import qualified Data.Set as S
import Data.List ( (!!) )

solution :: [Int] -> Int
solution list =  maximum $ map (\p -> xor ( fst p ) ( snd p ) )
[(noDoublets !! i, noDoublets !! j) | i <- [0..l - 2] ,
j <- [i + 1 ..l - 1]]
  where
  noDoublets :: [Int]
  noDoublets = S.toList $ S.fromList list
  l          :: Int
  l          = length noDoublets
