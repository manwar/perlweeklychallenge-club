module Challenge249
   where
import Data.List ( sort )
import qualified Data.Map.Strict as M
import qualified Data.Set as S
import Data.List.Split ( chunksOf ) 

count :: Eq a => a -> [a] -> Int
count _ [] = 0 
count d ( x:xs ) 
   |d == x = 1 + count d xs
   |otherwise = count d xs

findMap :: String -> M.Map Int Int
findMap s =
   let numbers = map read $ words s
       freqSet = map (\i -> (i , count i numbers )) $ S.toList $ S.fromList numbers
   in M.fromList freqSet

solution :: M.Map Int Int -> [Int] -> [[Int]]   
solution theMap numbers = if all even $ M.elems theMap then chunksOf 2 sorted else []
 where
  sorted = sort numbers

main :: IO ( ) 
main = do
   putStrLn "Enter an even number of integers, separated by blanks!"
   numberstrings <- getLine
   let numbers = map read $ words numberstrings
   print $ solution (findMap numberstrings) numbers 
