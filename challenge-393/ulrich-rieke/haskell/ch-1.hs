module Challenge393
   where

solution :: Int -> Int
solution n = length [(a , b , c) | a <- [1..n] , b <- [1..n] , c <- [1..n] , 
         a ^ 2 + b ^ 2 == c ^ 2]

main :: IO ( )
main = do
   putStrLn "Enter a positive integer!"
   numberstr <- getLine
   print $ solution $ read numberstr
