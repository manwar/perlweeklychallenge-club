module Challenge395_2
   where
import Data.List ( permutations , (!!))   


combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] , 
 x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]  

combineWord :: [String] -> Int -> String
combineWord words position = [w !! position | w <- words]

condition :: [String] -> Bool
condition words = 
   let l = length $ head words
       generated = map (\i -> combineWord words i ) [0..l - 1]
   in generated == words

solution :: [String] -> [[String]]
solution words = 
   let allCombis = combinations ( length $ head words ) words
       permus = map permutations allCombis
   in filter condition $ concat permus

main :: IO ( )
main = do
   putStrLn "Enter some words of equal length!"
   strings <- getLine
   print $ solution $ words strings
