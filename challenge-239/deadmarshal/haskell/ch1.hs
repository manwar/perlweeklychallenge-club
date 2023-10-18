module Ch1 where

sameString :: [String] -> [String] -> Bool
sameString xs ys = concat xs == concat ys
  
main :: IO ()
main = do
  print $ sameString ["ab","c"] ["a","bc"]
  print $ sameString ["ab","c"] ["ac","b"]
  print $ sameString ["ab","cd","e"] ["abcde"]
  
