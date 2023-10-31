module Challenge241_2
   where
import Data.List ( sortBy ) 

--for every number, find the smallest divisor which must, by
--definition of smallest and prime, be prime

divisors :: Int -> [Int]
divisors n = [d | d <- [2..n] , mod n d == 0 ]

primeDecompose :: Int -> [Int]
primeDecompose n = snd $ until ( ( == 1 ) . fst ) step ( n , [] )
 where
  step :: ( Int , [Int] ) -> ( Int , [Int] )
  step ( num , list ) = ( div num smallest , smallest : list )
   where 
    smallest = head $ divisors num 

mySorter :: Int -> Int -> Ordering
mySorter a b 
   |la /= lb = compare la lb
   |otherwise = compare a b
   where
    la = length $ primeDecompose a
    lb = length $ primeDecompose b

main :: IO ( )
main = do
   putStrLn "Please enter some unique positive integers greater than 2!"
   numberstrings <- getLine
   let numbers = map read $ words numberstrings
   print $ sortBy mySorter numbers
