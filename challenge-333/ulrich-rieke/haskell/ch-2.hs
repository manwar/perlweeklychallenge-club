module Challenge333_2
   where
   
solution :: [Int] -> [Int]
solution list = take ( length list ) $ foldl1 ( ++ ) $ map (\i -> if i == 0
 then replicate 2 0 else [i] ) list


main :: IO ( )
main = do
   putStrLn "Enter some integers separated by whitespace!"
   numberline <- getLine 
   print $ solution $ map read $ words numberline
