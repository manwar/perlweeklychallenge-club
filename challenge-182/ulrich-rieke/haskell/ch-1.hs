module Challenge182
  where
import Data.List ( findIndices )
import Data.List.Split ( splitOn )

solution :: [Int] -> Int
solution numberlist = minimum $ findIndices ( == theMax ) numberlist
where
  theMax :: Int
  theMax = maximum numberlist

main :: IO ( )
main = do
  putStrLn "Please enter some integers, separated by a blank!"
  input <- getLine ;
  let numbers = map read $ splitOn " " input
  print $ solution numbers
