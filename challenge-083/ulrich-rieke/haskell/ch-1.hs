module Challenge083
  where

solution :: String -> Int
solution str = sum $ map length myArray
  where
      myArray :: [String]
      myArray = init $ drop 1 $ words str
