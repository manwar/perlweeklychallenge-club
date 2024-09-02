module Challenge285_2
   where

denominations :: [Int]
denominations = [50, 25 , 10 , 5 , 1]

findCoinCombis :: [Int] -> Int -> [[Int]]
findCoinCombis [1] n  = [[n]] 
findCoinCombis ( den:rest ) n = [c:cs | c <- [0..div n den] , cs <- 
 findCoinCombis rest ( n - c * den )]

main :: IO ( )
main = do
   putStrLn "Enter an amount of money in pennies!" 
   amount <- getLine
   print $ length $ findCoinCombis denominations $ read amount
