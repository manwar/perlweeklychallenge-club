module Challenge302_2
   where

solution :: [Int] -> Int
solution list = 
   let intermediates = scanl1 ( + ) list
       smallest = minimum intermediates
       result = 1 - smallest
   in if result <= 0 then 1 - result else result

main :: IO ( ) 
main = do   
   putStrLn "Enter some integers separated by whitespace!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
