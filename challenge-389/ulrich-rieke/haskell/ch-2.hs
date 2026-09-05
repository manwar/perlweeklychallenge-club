module Challenge389_2
   where
import Data.List ( init , (!!) , sort)
import Data.List.Split ( divvy )

isUndulating :: [Int] -> Bool
isUndulating numbers 
   |l == 1 = True
   |l == 2 = head numbers /= last numbers
   |otherwise = all (\i -> ((differences !! i > 0) && ( differences !! (i + 
               1 ) < 0 )) || ((differences !! i < 0 ) && ( differences !!
                (i + 1 ) > 0 ) )) $ init indices 
    where 
      differences :: [Int]
      differences = map (\subli -> last subli - head subli ) $ divvy 2 1
       numbers
      indices :: [Int]
      indices = [0..length differences - 1]
      l       :: Int
      l       = length numbers

allSubarrays :: [Int] -> [[Int]]
allSubarrays list = [take n $ drop howmany list | n <- [1..length list] ,
 howmany <- [0..length list - n]]

myLength :: [Int] -> Int
myLength list = if all ( == myStarter ) list then 1 else length list
   where
      myStarter :: Int
      myStarter = head list

solution :: [Int] -> Int
solution = last . sort . map myLength . filter isUndulating . allSubarrays

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by whitespace!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
