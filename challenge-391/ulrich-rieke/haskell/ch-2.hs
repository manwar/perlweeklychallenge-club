module Challenge391_2
   where
import Data.List.Split ( chunksOf ) 
import Data.List ( (!!) , sortOn )

toPairs :: [Int] -> [[Int]]
toPairs = chunksOf 2

sortedPairs :: [[Int]] -> [[Int]]
sortedPairs sorted = sortOn head sorted 

solution :: [[Int]] -> Int
solution boxes = length $ snd $ until ( (== l ) . fst ) step ( 1 , [head
      sorted] )
   where
      step :: (Int , [[Int]]) -> (Int , [[Int]] )
      step (index , currentList ) = (index + 1 , if (head $ sorted !! index) 
          > ( head $ last currentList ) && ((last $ sorted !! index) > ( last
             $ last currentList )) then currentList ++ [ sorted !! index ]
              else currentList )
      l     :: Int
      l     = length boxes
      sorted :: [[Int]]
      sorted = sortedPairs boxes 

main :: IO ( ) 
main = do
   putStrLn "Enter an even number of positive integers!"
   numberline <- getLine
   let pairs = toPairs $ map read $ words numberline
   print $ solution pairs
