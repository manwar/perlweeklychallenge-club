module Challenge134
  where
import qualified Data.Set as S

isPandigital :: Integer -> Bool
isPandigital s = (S.size $ S.fromList $ show s ) == 10

solution :: [Integer]
solution = take 5 $ filter isPandigital [start , start + 1 ..]
where
  start :: Integer
  start = 1023456789
