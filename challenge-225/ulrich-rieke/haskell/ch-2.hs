module Challenge225_2
  where

find_left_array :: [Int] -> [Int]
find_left_array list = [0] ++ map (\i -> sum $ take i list ) [1..limit + 1]
where
  limit :: Int
  limit = div ( length list ) 2

find_right_array :: [Int] -> [Int]
find_right_array list = map (\i -> sum $ drop i rightPart ) [0..length
rightPart - 1] ++ [0]
where
  l          :: Int
  l          = length list
  left_limit :: Int
  left_limit = if odd l then div l 2 else div l 2 - 1
  rightPart  :: [Int]
  rightPart = drop left_limit list

solution :: [Int] -> [Int]
solution list
  |length list == 1 = [0]
  |otherwise = zipWith op (find_left_array list) ( find_right_array list )
    where
      op :: Int -> Int -> Int
      op a b = abs( a - b )

main :: IO ( )
main = do
  putStrLn "Enter some digits, separated by blanks!" ;
  numberstrings <- getLine
  print $ solution $ map read $ words numberstrings
