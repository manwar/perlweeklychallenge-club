module Challenge283
   where
import Data.List ( sort , group ) 

solution :: [Int] -> Int
solution = head . head . filter ( (== 1 ) . length ) . group . sort 

main :: IO ( )
main = do
   putStrLn "Enter some integers several times , one only once!" 
   numberline <- getLine 
   print $ solution $ map read $ words numberline
