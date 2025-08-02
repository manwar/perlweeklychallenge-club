module Challenge304
   where
import Data.List( group , findIndex ) 

findInitialArray :: [Int] -> [Int]
findInitialArray list = case findIndex( == 1 ) list of
   Just i -> if odd i then [0 , 1] else [1,0]
   Nothing -> [0 , 1]

solution :: [Int] -> Int -> Bool
solution list number 
   |l == 1 = False 
   |otherwise = if any (\subli -> (length subli > 1) && head subli == 1 ) grouped then 
    False else flipped >= number
    where
     grouped :: [[Int]]
     grouped = group list
     l       :: Int
     l = length list
     iniArray :: [Int]
     iniArray = findInitialArray list
     comparison :: [Int]
     comparison = take l $ cycle iniArray 
     zipped :: [(Int , Int)]
     zipped = zip list comparison 
     flipped :: Int
     flipped = length $ filter (\p -> fst p == 0 && ( snd p == 1 ) ) zipped

main :: IO ( ) 
main = do
   putStrLn "Enter some 1 and 0 separated by spaces!"
   numberline <- getLine
   putStrLn "Enter a positive integer!" 
   number <- getLine
   print $ solution ( map read $ words numberline ) ( read number )
