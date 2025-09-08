module Ch2 where

minmax :: Ord a => [a] -> (Maybe a,Maybe a)
minmax [] = (Nothing,Nothing)
minmax [x] = (Just x,Just x)
minmax (x:y:xs)
  | x < y = let (minVal,maxVal) = minmax (x:xs)
            in (minVal, max (Just y) maxVal)
  | otherwise = let (minVal,maxVal) = minmax (y:xs)
                in (minVal, max (Just x) maxVal)

maxDistance :: (Ord a, Num a) => [a] -> [a] -> Maybe a
maxDistance xs ys = liftA2 max diff1 diff2
  where
    (min_xs,max_xs) = minmax xs
    (min_ys,max_ys) = minmax ys
    diff1 = liftA2 (-) max_xs min_ys
    diff2 = liftA2 (-) max_ys min_xs
  
main :: IO ()
main = do
  print $ maxDistance [4,5,7] [9,1,3,4]
  print $ maxDistance [2,3,5,4] [3,2,5,5,8,7]
  print $ maxDistance [2,1,11,3] [2,5,10,2]
  print $ maxDistance [1,2,3] [3,2,1]
  print $ maxDistance [1,0,2,3] [5,0]

