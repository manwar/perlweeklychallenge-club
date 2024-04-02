module Challenge263_2
   where
import Data.List.Split ( chunksOf )
import Data.List ( sortOn , groupBy )

toPairs :: [Int] -> [(Int , Int)]
toPairs = map (\p -> (head p, last p) ) . chunksOf 2

convert :: [(Int , Int)] -> [(Int , Int)]
convert pairs = map (\subli -> ( fst $ head subli , sum $ map snd subli ))
 $ groupBy (\a b -> fst a == fst b ) $ sortOn fst pairs

main :: IO ( )
main = do
   putStrLn "Enter an even number of integers representing pairs!"
   firstNumbers <- getLine
   putStrLn "Enter another even number of integers!"
   secondNumbers <- getLine
   let firstPairs = toPairs $ map read $ words firstNumbers
       secondPairs = toPairs $ map read $ words secondNumbers
   print $ convert ( firstPairs ++ secondPairs )    
