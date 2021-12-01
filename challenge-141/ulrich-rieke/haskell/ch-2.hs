module Challenge141_2
  where
import Data.List ( subsequences )
import Data.Char ( digitToInt )

solution :: Int -> Int -> Int
solution m n = length $ filter (\i -> mod i n == 0 ) $ map convertToNumber
$ filter ( not . null ) $ init $ subsequences $ map digitToInt $ show m
where
  convertToNumber :: [Int] -> Int
  convertToNumber list = read $ foldl1 (++) $ map show list
