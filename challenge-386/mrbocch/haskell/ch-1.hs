import Data.Function
import Data.Maybe (fromJust)
import Data.Map (Map)
import qualified Data.Map as Map

digits :: Map Char Int 
digits = ['0'..'9'] ++ ['A'..'Z'] ++ ['a'..'z'] ++ ['+','/']
       & map (, 1)
       & scanl (\(_,acc) (c,n) -> (c, n+acc)) ('_', -1)
       & tail 
       & Map.fromList

cToInt :: Char -> Int
cToInt = fromJust . flip Map.lookup digits

reverseBase :: String -> Int -> Int
reverseBase s base = map cToInt s
                   & reverse
                   & flip zip [0..]
                   -- mapAccuml | clojure transduce
                   & map (\(c, exp) -> c * base^exp)
                   & sum
main :: IO ()
main = do
    print $ reverseBase "101010" 2  == 42
    print $ reverseBase "EEADEE" 16 == 15642094
    print $ reverseBase "755"    8  == 493
    print $ reverseBase "1BRJB"  36 == 2228519
    print $ reverseBase "7MyqL"  64 == 123456789
