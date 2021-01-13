module Challenge073_2
  where

solution :: [Int] -> [Int]
solution list = [0 , head list] ++ map myFunction [2..length list - 1]
  where
      myFunction :: Int -> Int
      myFunction n
        |all ( (head sublist) == ) sublist = 0
        |otherwise                        = minimum sublist
      where
        sublist = take n list
