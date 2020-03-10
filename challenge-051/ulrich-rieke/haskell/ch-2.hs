module Challenge051_2
  where
import Data.List ( subsequences, (!!) )
import Data.Char ( digitToInt )
import qualified Data.Set as S

isColourful :: Int -> Bool
isColourful n
  |n < 100 || n > 999 = False
  |otherwise =
      let numberstring = show n
          combis = filter ( ( 2 <= ) . length ) $ subsequences numberstring
      numbers = map ( map digitToInt ) combis
      products = map product numbers
      allNumbers = products ++ [ read  [numberstring !! 0] ,
      read  [numberstring !! 1] , read [numberstring !! 2 ]]
      numberset = S.fromList allNumbers
      in S.size numberset == 7

solution :: [Int]
solution = filter isColourful [100..999]
