module Challenge176
  where
import Data.Char ( digitToInt )
import Data.List ( sort )

multiples :: Int -> [Int]
multiples n = map ( * n ) [2 .. 6]

findDigits :: Int -> [Int]
findDigits = sort . map digitToInt . show

isPermutedMultiple :: Int -> Bool
isPermutedMultiple n = all ( == startDigits ) $ map findDigits $ multiples
n
where
  startDigits :: [Int]
  startDigits = findDigits n

solution :: Int
solution = head $ filter isPermutedMultiple [1 , 2 ..]
