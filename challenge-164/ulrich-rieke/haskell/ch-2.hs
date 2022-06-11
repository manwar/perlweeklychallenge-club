module Challenge164_2
  where
import Data.Char( digitToInt )

digitSquare :: Int -> Int
digitSquare n = sum $ map ( ( ^ 2 ) . digitToInt ) $ show n

isHappy :: Int -> Bool
isHappy n = last ( until (\li -> last li == 1 || count ( last li ) li > 1 )
step [n] ) == 1
where
  count :: Int -> [Int] -> Int
  count d  list = length $ filter ( == d ) list
  step :: [Int] -> [Int]
  step aList = aList ++ [ digitSquare $ last aList ]

solution :: [Int]
solution = take 8 $ filter isHappy [1 , 2 ..]
