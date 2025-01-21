module Challenge305
   where

toDecimal :: [Int] -> Int
toDecimal binaries = sum $ zipWith ( * ) (reverse binaries ) ( iterate ( * 2 ) 1 )

isPrime :: Int -> Bool
isPrime n
   |n == 0 = False
   |n == 1 = False
   |n == 2 = True
   |otherwise = all(\i -> mod n i /= 0 ) [2..limit]
    where
     limit = floor $ sqrt $ fromIntegral n

makeDecimals :: [Int] -> [Int]
makeDecimals binaries = map (\i -> toDecimal $ take i binaries ) [1..length binaries]

solution :: [Int] -> [Bool]
solution list = 
   let decimals = makeDecimals list
   in map isPrime decimals

main :: IO ( ) 
main = do
   putStrLn "Enter some binary digits separated by blanks!" 
   digitline <- getLine
   print $ solution $ map read $ words digitline

