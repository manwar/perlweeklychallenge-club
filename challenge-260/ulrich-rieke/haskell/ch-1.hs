module Challenge260
   where
import qualified Data.Set as S

count :: Eq a => a -> [a] -> Int
count _ [] = 0 
count d (x:xs)
   |d == x = 1 + count d xs
   |otherwise = count d xs

solution :: [Int] -> Int
solution list = if l1 == l2 then 1 else 0
 where
  uniques :: S.Set Int
  uniques = S.fromList list
  frequencies :: S.Set Int
  frequencies = S.fromList $ map (\i -> count i list ) $ S.toList uniques
  l1 :: Int
  l1 = S.size uniques 
  l2 :: Int
  l2 = S.size frequencies

main :: IO ( )
main = do
   putStrLn "Enter some integers, separated by blanks!" 
   numberline <- getLine
   print $ solution $ map read $ words numberline

