module Challenge217_2
  where
import Data.List ( sort , permutations )

concatNumbers :: [Int] -> Integer
concatNumbers list = read $ foldl1 ( ++ ) $ map show list

solution :: [Int] -> Integer
solution list = maximum $ map concatNumbers $ permutations list
