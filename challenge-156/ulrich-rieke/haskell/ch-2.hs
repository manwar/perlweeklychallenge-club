module Challenge156_2
  where
import Data.List ( any , subsequences )

isWeird :: Int -> Bool
isWeird n = (sum properDivisors > n) && ( not $ any ( == n ) $ map sum $
filter (\li -> (length li > 1) && (length li < len) ) $ subsequences
properDivisors )
where
  properDivisors :: [Int]
  properDivisors = [d | d <- [1 .. div n 2 + 1] , mod n d == 0]
  len            :: Int
  len            = length properDivisors

solution :: Int -> Int
solution n = if isWeird n then 1 else 0
