module Challenge270_2
   where

findCombinations :: [Int] -> [([Int] , [Int])]
findCombinations list =
   let max = maximum list
       smaller = filter ( /= max ) list
       totalDiff = sum $ map (\i -> max - i ) smaller
   in if (length smaller > 1) then [(replicate o 1 , replicate t 2) | o <-
   [0..totalDiff] , t <-  [0..div totalDiff 2] , sum ( replicate o 1 ++
   replicate t 2 ) == totalDiff] else [(replicate totalDiff 1, [])]

findBestCombi :: [([Int] , [Int] )] -> Int -> Int -> Int
findBestCombi one_two_combinations oneprice twoprice = minimum $ map (\p -> 
 (length $ fst p) * oneprice + ( length $ snd p ) * twoprice ) 
 one_two_combinations 

main :: IO ( ) 
main = do
   putStrLn "Enter some integers , separated by blanks!" 
   numberstrings <- getLine
   putStrLn "Enter a price for one-level operations!"
   xstring <- getLine
   putStrLn "Enter a price for two-level operations!"
   ystring <- getLine
   let numbers = map read $ words numberstrings
       x       = read xstring
       y       = read ystring
   if all (\i -> i == head numbers ) numbers then print 0 else print $
    findBestCombi (findCombinations numbers ) x y 
