module Challenge249_2
   where
import Data.List ( (!!) , permutations , findIndices , findIndex )

solution :: String -> [Int]
solution s =
   let allIs = findIndices  (\c -> c == 'I') s
       allDs = findIndices (\c -> c == 'D') s
       allPermus = permutations [0..length s]
   in case findIndex (\perm -> myCondition perm allIs allDs ) allPermus of
    Just pos -> allPermus !! pos 
    Nothing -> []

myCondition :: [Int] -> [Int] -> [Int] -> Bool
myCondition permu theIs theDs = (all (\i -> permu !! i <  permu !! ( i + 1 ) )
 theIs) && ( all (\n ->  permu !! n  >  permu !! ( n + 1 )) theDs )  
   
main :: IO ( )
main = do
   putStrLn "Enter a string consisting of capital I's and D's only!" 
   string <- getLine
   print $ solution string
