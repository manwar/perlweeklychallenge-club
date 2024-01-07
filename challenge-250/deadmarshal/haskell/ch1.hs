module Ch1 where

smallestIndex :: Integral a => [a] -> a
smallestIndex xs =
  aux $ zip [0..] xs
  where
    aux [] = -1
    aux ((i,e):tl)
      | mod i 10 == e = i
      | otherwise = aux tl

main :: IO ()
main = do
  print $ smallestIndex [0,1,2]
  print $ smallestIndex [4,3,2,1]
  print $ smallestIndex [1,2,3,4,5,6,7,8,9,0]

