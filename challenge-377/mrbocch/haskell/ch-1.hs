import qualified Data.Set as Set 

phoenix :: (b -> c -> d) -> (a -> b) -> (a -> c) -> a -> d 
phoenix f g h a = f (g a) (h a)

(.:) :: (c -> d) -> (a -> b -> c) -> a -> b -> d 
(.:) f g x y = f (g x y) 

reverseExistence :: String -> Bool
reverseExistence = phoenix (not .: Set.disjoint) (Set.fromList . windows 2)
                                                 (Set.fromList . windows 2 . reverse)
  where 
    windows :: Int -> [a] -> [[a]]
    windows k xs@(x:rest)
      | length xs == k = [take k xs] 
      | otherwise      = take k xs : windows k rest  
 
main :: IO ()
main = do
  print $ reverseExistence "abcba"   == True 
  print $ reverseExistence "racecar" == True 
  print $ reverseExistence "abcd"    == False 
  print $ reverseExistence "banana"  == True 
  print $ reverseExistence "hello"   == True 

