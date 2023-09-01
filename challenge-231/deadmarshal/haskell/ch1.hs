module Ch1 where

minMax :: [Int] -> [Int]
minMax xs =
  filter (\x -> x /= mn && x /= mx) xs
  where
    mn = foldl min (maxBound :: Int) xs
    mx = foldl max (minBound :: Int) xs 

main :: IO ()
main = do 
  print $ minMax [3,2,1,4]
  print $ minMax [3,1]
  print $ minMax [2,1,3]
  
