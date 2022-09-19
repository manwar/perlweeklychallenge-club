module Challenge176_2
  where
import Data.Char( digitToInt)

isReversible :: Int -> Bool
isReversible n = all odd $ digits sum
where
  digits :: Int -> [Int]
  digits = map digitToInt . show
  reversed :: Int
  reversed = read $ reverse $ show n
  sum :: Int
  sum = n + reversed

solution :: [Int]
solution = filter isReversible [1 .. 100]
