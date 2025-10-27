module Challenge344
   where

decompose :: Int -> [Int]
decompose number = reverse $ snd $ until ( (== 0 ) . fst ) step ( number , [] ) 
   where
    step :: (Int , [Int]) -> (Int , [Int])
    step ( aNum , list ) = (div aNum 10 , list ++ [mod aNum 10] )

compose :: [Int] -> Int
compose list = sum $ map (\p -> snd p * (10 ^ fst p)) $ zip [0 , 1..]
 ( reverse list )

solution :: [Int] -> Int -> [Int]
solution list number = decompose ( compose list + number )

main :: IO ( ) 
main = do
   putStrLn "Enter some integers separated by blanks!"
   numberline <- getLine
   putStrLn "Enter an integer!"
   myNum <- getLine
   print $ solution ( map read $ words numberline ) ( read myNum )
