module Challenge238_2
   where
import Data.Char ( digitToInt ) 
import Data.List ( sortBy ) 

decompose :: Int -> [Int]
decompose = map digitToInt . show

findSteps :: Int -> Int
findSteps n 
   |n < 10 = 0 
   |otherwise = fst $ until ( ( < 10 ) . snd ) action ( 0 , n )
   where
    action :: (Int , Int ) -> (Int , Int )
    action ( count , d )  = ( count + 1 , product $ decompose d )

mySorter :: Int -> Int -> Ordering
mySorter d1 d2 
   |st1 /= st2 = compare st1 st2
   |otherwise = compare d1 d2
   where
    st1 = findSteps d1
    st2 = findSteps d2

solution :: [Int] -> [Int]
solution = sortBy mySorter

main :: IO ( )
main = do
   putStrLn "Enter some positive integers , separated by blanks!"
   numberstrings <- getLine
   let numbers = map read $ words numberstrings
   print $ solution numbers
