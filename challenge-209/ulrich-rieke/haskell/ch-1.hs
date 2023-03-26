module Challenge209
  where
import Data.List.Split ( chunksOf )
import qualified Data.Set as S
import Data.Char( intToDigit )

solution :: String -> Int
solution s
  |not $ myCondition parts = 0
  |(last parts == "00" || last parts == "0") && myCondition parts = 1
  |otherwise = 0
  where
    parts :: [String]
    parts = chunksOf 2 s
    myCondition :: [String] -> Bool
    myCondition someParts = all (\p -> S.null $ S.intersection (S.fromList p)
    (S.fromList $ map intToDigit [2 , 3 , 4 , 5 , 6 , 7 , 8  , 9]) ) someParts
