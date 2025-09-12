module Challenge338_2
   where

pairUp :: [Int] -> [Int] -> [(Int , Int)]
pairUp firstList secondList = [(a , b)| a <- firstList , b <- secondList]

solution :: [Int] -> [Int] -> Int
solution firstList secondList = 
   let allPairs = pairUp firstList secondList
       differences = map (\p -> abs( fst p - snd p ) ) allPairs
   in maximum differences

main :: IO ( )
main = do 
   putStrLn "Enter some integers separated by whitespace!"
   firstLine <- getLine
   putStrLn "Enter some more integers separated by whitespace!"
   secondLine <- getLine
   print $ solution ( map read $ words firstLine ) ( map read $ words secondLine )
