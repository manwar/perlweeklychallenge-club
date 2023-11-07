{-# LANGUAGE ScopedTypeVariables #-}
module Challenge242_2
   where

enterNlines :: Int -> Int -> IO [String]
enterNlines n original
   |n <= 0 = return []
   |otherwise = do 
      putStr ("Enter " ++ show n ++ " lines of " ++
       show original ++ " numbers")
      putStrLn " 0 and 1" 
      numberstrings <- getLine 
      xs <- enterNlines ( n - 1 ) original
      let ret = (numberstrings : xs)
      return ret

myFlip :: Int -> Int
myFlip n = if n == 1 then 0 else 1

convert :: [[Int]] -> [[Int]]
convert = map ( map myFlip . reverse ) 

main :: IO ( )
main = do
   putStrLn "Enter some 0 and 1 , separated by blanks!" ;
   numberstrings <- getLine 
   let ct = length $ words numberstrings
       (numbers :: [Int] ) = map read $ words numberstrings 
   additionalNumbers <- enterNlines ( ct - 1 ) ct
   let allNums = numberstrings : additionalNumbers
       allNumbers = map ( map read . words ) allNums 
   print $ convert allNumbers    
