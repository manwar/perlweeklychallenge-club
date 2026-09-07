

zigzag [] = 0
zigzag (x:xs) = max (length group) (zigzag xs)
  where
    group = max (nextDown x xs) (nextUp x xs)
       
    nextDown :: Int -> [Int] -> [Int]
    nextDown p [] = [p]
    nextDown prev (x:xs)
      | prev <= x = [prev]
      | otherwise = prev : nextUp x xs 

    nextUp :: Int -> [Int] -> [Int]
    nextUp p [] = [p]
    nextUp prev (x:xs)
      | prev >= x = [prev]
      | otherwise = prev : nextDown x xs 

main :: IO ()
main = do
  print $ zigzag [9, 4, 2, 10, 7, 8, 8, 1, 9] == 5
  print $ zigzag [1, 7, 4, 9, 2, 5] == 6
  print $ zigzag [1, 2, 3, 4, 5] == 2
  print $ zigzag [4, 4, 4] == 1
  print $ zigzag [10, 20, 15, 12, 18] == 3
