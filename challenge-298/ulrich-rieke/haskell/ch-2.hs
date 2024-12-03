module Challenge298_2
   where
import Data.List.Split ( chunksOf ) 
import Data.List ( (!!) , findIndex )
import Data.Maybe ( fromJust )   

findRightLists :: [[Int]] -> Int -> [[Int]]
findRightLists sublists index = filter (\subli -> head subli >= ( last $ sublists 
 !! index ) ) sublists

solution :: [Int] -> [Int]
solution list = 
  let allPairs = chunksOf 2 list
      starters = map head allPairs
      zipped = zip [0 , 1 ..] allPairs
      correspondingLists = map (\p -> (fst p , findRightLists allPairs ( fst p ) )) 
       zipped 	
  in map (\p -> if null $ snd p then -1 else fromJust $ findIndex ( == (minimum
   $ concat $ snd p) ) starters ) correspondingLists 

main :: IO ( ) 
main = do
   putStrLn "Enter some integers separated by whitespace!"
   putStrLn "Every first , third and so on integer should be unique!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
