module Challenge215
  where
import Data.List ( sort )

solution :: [String] -> Int
solution terms = length $ filter ( not . isSorted ) terms
where
  isSorted :: String -> Bool
  isSorted str = str == sort str

main :: IO ( )
main = do
  putStrLn "Enter some words, separated by a blank!"
  terms <- getLine
  let theWords = words terms
  print $ solution theWords
