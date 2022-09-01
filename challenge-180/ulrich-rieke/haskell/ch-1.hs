module Challenge180
  where
import Data.Char ( isSpace )
import qualified Data.Set as S
import Data.List ( findIndices )

count :: Eq a => a -> [a] -> Int
count c [] = 0
count d ( x:xs )
  |d == x = 1 + count d xs
  |otherwise = count d xs

solution :: String -> Int
solution s = minimum $ concat $ map (\c -> findIndices ( == c ) s ) $
filter (\c -> count c s == 1 ) $ S.toList $ S.fromList s
