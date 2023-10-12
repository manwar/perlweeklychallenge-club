module Ch2 where

import Data.List

digits :: Integral a => a -> [a]
digits 0 = []
digits x = digits (div x 10) ++ [mod x 10]

helper :: Integral a => a -> a -> a
helper acc n
  | n < 10 = acc
  | otherwise =
    helper (acc+1) (product $ digits n)
 
persistenceSort :: Integral a => [a] -> [a]
persistenceSort xs =
  sortBy (\a b -> let ha = helper 0 a; hb = helper 0 b in
                    if ha /= hb then
                      compare ha hb 
                    else compare a b) xs
  
main :: IO ()
main = do
  print $ persistenceSort [15,99,1,34]
  print $ persistenceSort [50,25,33,22]

