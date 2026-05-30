import qualified Data.Map as Map
import Data.Function 

singleCommonWord :: [String] -> [String] -> Int 
singleCommonWord = ((.) . (.)) (Map.size . Map.filter (==2))
                               (on (Map.intersectionWith (+)) tally)
  where 
    tally :: Ord k => [k] -> Map.Map k Int
    tally xs = tally' xs Map.empty
      where 
        tally' :: Ord k => [k] -> Map.Map k Int -> Map.Map k Int
        tally' [] map = map  
        tally' (x:rest) map  
          | Map.member x map = tally' rest (Map.adjust (+1) x map)
          | otherwise = tally' rest (Map.insert x 1 map) 

main :: IO ()
main = do
  print $ singleCommonWord ["apple", "banana", "cherry"] ["banana", "cherry", "date"] == 2
  print $ singleCommonWord ["a", "ab", "abc"] ["a", "a", "ab", "abc"]                 == 2 
  print $ singleCommonWord ["orange", "lemon"] ["grape", "melon"]                     == 0 
  print $ singleCommonWord ["test", "test", "demo"] ["test", "demo", "demo"]          == 0 
  print $ singleCommonWord ["Hello", "world"] ["hello", "world"]                      == 1

