module Challenge327_2
   where

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] , 
 x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]  

solution :: [Int] ->[[Int]]
solution numberlist = filter (\subli -> (abs ( head subli - last subli )) == mini )
   allCombis
 where
  allCombis :: [[Int]]
  allCombis = combinations 2 numberlist
  mini :: Int
  mini = minimum $ map (\subli -> abs( head subli - last subli ) ) allCombis

main :: IO ( )
main = do
   putStrLn "Enter a list of distinct integers!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
