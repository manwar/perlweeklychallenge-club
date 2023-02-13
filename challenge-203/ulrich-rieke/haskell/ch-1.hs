module Challenge203
  where

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] ,
x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]

myCondition :: [Int] -> Bool
myCondition list = (sum $ init list ) == last list

solution :: [Int] -> Int
solution = length . filter myCondition . combinations 4

keepAskingForInput :: IO [Int]
keepAskingForInput = do
  putStrLn "Enter at least 4 integers, separated by blanks!"
  numberstrings <- getLine
  let strings = words numberstrings
  if length strings >= 4
  then do
      return $ map read strings
  else do
      keepAskingForInput

main :: IO ( )
main = do
  numbers <- keepAskingForInput
  print $ solution numbers
