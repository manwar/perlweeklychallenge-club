module Challenge184_2
  where
import Data.Char ( digitToInt , isDigit , isLower )
import Data.List( intersperse )

takeApart :: String -> ( [Int] , [Char] )
takeApart st = (map digitToInt $ filter isDigit st , filter isLower st)

solution :: [String] -> ([[Int]] , [[Char]] )
solution input = ( filter ( not .null ) $ map fst pairs ,
      filter ( not . null ) $ map ( intersperse ',' ) $ map snd pairs )
where
  pairs = map takeApart input
