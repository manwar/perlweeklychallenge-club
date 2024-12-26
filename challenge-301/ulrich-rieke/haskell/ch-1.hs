module Challenge301
   where
import Data.List ( permutations ) ;

convert :: [Int] -> Integer
convert list = read $ foldl1 ( ++ ) $ map show list

solution :: [Int] -> Integer
solution list = maximum $ map convert $ permutations list 

main :: IO ( ) 
main = do
   putStrLn "Enter some integers separated by whitespace!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
