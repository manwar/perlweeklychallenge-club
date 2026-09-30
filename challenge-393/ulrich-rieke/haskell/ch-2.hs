module Challenge393_2
   where
import Data.Char ( ord )

isPrime :: Int -> Bool
isPrime n 
   |n == 0 = False
   |n == 1 = False
   |n == 2 = True
   |otherwise = all (\d -> mod n d /=  0) [2..root]
      where
         root :: Int
         root = floor $ sqrt $ fromIntegral n

solution :: String -> Int
solution str = if isPrime total then 0 else min ( upperPrime - total ) ( total 
 - lowerPrime )
  where
    total :: Int
    total = sum $ map ord str
    upperPrime :: Int
    upperPrime = head $ filter isPrime [total + 1 , total + 2 ..]
    lowerPrime :: Int
    lowerPrime = head $ filter isPrime [total - 1 , total - 2 ..]

main :: IO ( )
main = do
   putStrLn "Enter a word consisting of English alphabetic characters only!"
   word <- getLine
   print $ solution word
