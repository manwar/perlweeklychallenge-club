module Ch1 where

main :: IO ()
main = do
  print $ scanl1 (+) [1,2,3,4,5]
  print $ scanl1 (+) [1,1,1,1,1]
  print $ scanl1 (+) [0,-1,1,2]

