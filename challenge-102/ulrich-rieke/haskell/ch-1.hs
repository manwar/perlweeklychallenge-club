module Challenge102
  where

isPerfectSquare :: Int -> Bool
isPerfectSquare n = root  == ( fromIntegral $ floor root )
  where
      root = sqrt $ fromIntegral n

isRare :: Int -> Bool
isRare n = isPerfectSquare ( n + reversed ) && isPerfectSquare (n - reversed )
where
  reversed :: Int
  reversed = read $ reverse $ show n

solution :: Int -> [Int]
solution size = filter isRare [ 10 ^ ( size - 1 ) .. (10 ^ size) - 1]
