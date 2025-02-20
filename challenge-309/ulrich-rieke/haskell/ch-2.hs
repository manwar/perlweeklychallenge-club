module Challenge309_2
   where

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] , 
 x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]  

solution :: [Int] -> Int 
solution = minimum . map (\subli -> abs ( head subli - last subli )) .
 combinations 2

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by whitespace!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
