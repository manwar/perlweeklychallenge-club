module Challenge220_2
  where
import Data.List.Split ( divvy )
import Data.List ( permutations )

isRootNumber :: Int -> Bool
isRootNumber n = rootint * rootint == n
where
  rootint :: Int
  rootint = floor $ sqrt $ fromIntegral n

condition :: [Int] -> Bool
condition = all isRootNumber . map sum . divvy 2 1

solution :: [Int] -> [[Int]]
solution = filter condition . permutations

main :: IO ( )
main = do
  putStrLn "Enter some integers, separated by blanks!"
  numbers <- getLine
  print $ solution $ map read $ words numbers
