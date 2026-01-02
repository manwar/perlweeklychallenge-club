module Challenge354_2
   where
import Data.List ( init )
import Data.List.Split ( chunksOf ) 

enterLines :: IO [String]
enterLines = do
   line <- getLine
   if null line then return []
   else (line : ) <$> enterLines     

doNTimes :: Int -> ( a -> a ) -> a -> a
doNTimes 0 _ start = start
doNTimes n f start = doNTimes ( n - 1 ) f ( f start )

rotateLeft :: [Int] -> [Int]
rotateLeft list = (last list) : ( init list )

solution :: [[Int]] -> Int -> [[Int]]
solution input shifts =
   let allnumbers = concat input
       shifted = doNTimes shifts rotateLeft allnumbers 
   in chunksOf ( length $ head input ) shifted 

main :: IO ( )
main = do 
   putStrLn "Enter a m x n matrix of integers , <return> to end!"
   inputlines <- enterLines
   putStrLn "Enter the number of shifts you want!"
   shiftnum <- getLine
   let allNumbers = map ( map read . words ) inputlines
   print $ solution allNumbers ( read shiftnum :: Int )
