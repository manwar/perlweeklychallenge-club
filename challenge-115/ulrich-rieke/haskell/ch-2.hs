module Challenge115_2
  where
import Data.List ( (\\) , sortBy, sort )
import Data.Char ( intToDigit )
import qualified Data.Set as S

--order the digits in descending order, pick out the smallest even digit
--if it exists and put it at the end of the number
--no even number can be produced if all digits are odd

listToNumber :: [Int] -> Int
listToNumber list = read $ foldl1 ( ++ ) $ map(\i -> [intToDigit i]) list

--if no even number can be produced 0 is returned
solution :: [ Int ] -> Int
solution list
  |all odd list = 0
  |otherwise = listToNumber ((sortedList \\ [smallestEven]) ++
    [smallestEven])
  where
    sortedList :: [Int]
    sortedList = sortBy myFunc list
    myFunc :: Int -> Int -> Ordering
    myFunc a b
      |a > b = LT
      |a == b = EQ
      |a < b = GT
    smallestEven :: Int
    smallestEven = head $ dropWhile ( not . even ) $ reverse sortedList
