module Challenge258_2
   where
import Data.Bits

solution :: [Int] -> Int -> Int
solution list ones = sum $ map snd $ filter ((== ones ) . popCount . fst )
 $ zip ([0,1..] ::[Int] ) list

main :: IO ( )
main = do 
   putStrLn "Enter some integers, separated by spaces!" ;
   numberline <- getLine
   putStrLn "Enter an integer k!" 
   kVal <- getLine
   let numbers = map read $ words numberline
       k       = read kVal
   print $ solution numbers k    
