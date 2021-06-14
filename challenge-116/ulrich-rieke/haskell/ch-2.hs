module Challenge116_2
  where
import Data.Char ( digitToInt )

solution :: Int -> Int
solution n = if (realToFrac $ floor $ sqrt $ fromIntegral theSum) == ( sqrt $
      fromIntegral theSum ) then 1 else 0
  where
      squaredigits :: [ Int ]
      squaredigits = map (^ 2 ) $ map digitToInt $ show n
      theSum :: Int
      theSum = sum squaredigits
