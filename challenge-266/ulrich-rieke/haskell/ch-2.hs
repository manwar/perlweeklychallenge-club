module Challenge266_2
   where
import Data.List ( (!!) )

isSquare :: [[Int]] -> Bool
isSquare matrix = all (\i -> length ( matrix !! i ) == l ) [0..l - 1]
 where
  l :: Int
  l = length matrix

condition :: [[Int]] -> Bool
condition matrix = all ( /= 0 ) [(matrix !! r ) !! c | r <- [0..l - 1] , 
 c <- [0..l - 1] , r == c ] && all ( /= 0 ) [(matrix !! r ) !! c | r <-
 [0..l - 1] , c <- [0..l - 1] , r + c == l - 1] && all ( == 0 ) [(matrix !! r ) !! c |
 r <- [0..l - 1] , c <- [0..l - 1 ] , r /= c , r + c /= l - 1 ]
 where
  l :: Int
  l = length matrix

enterNLines :: Int -> IO [String]
enterNLines n 
   |n <= 0 = return []
   |otherwise = do
      putStrLn "Enter some integers, separated by blanks!"
      x <- getLine
      xs <- enterNLines ( n - 1 )
      let ret = (x:xs)
      return ret

main :: IO ( ) 
main = do
   putStrLn "Enter some integers separated by blanks!" 
   numberstrings <- getLine
   restLines <- enterNLines ( length ( words numberstrings ) - 1 ) 
   let numstrings = (numberstrings:restLines)
       matrix = map ( map read . words ) numstrings
   if and [isSquare matrix , condition matrix] then print "true" else print "false"   
