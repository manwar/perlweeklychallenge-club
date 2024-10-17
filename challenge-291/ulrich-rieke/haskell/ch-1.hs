module Challenge291
   where
import Data.List ( tail , findIndex )

convert :: ([Int] , [Int] ) -> (Int , Int )
convert ( firstList , secondList ) 
   |null firstList = (0 , sum $ tail secondList ) 
   |otherwise = if null secondList then ( sum firstList , 0 ) else ( sum  
     firstList , sum $ tail secondList ) 
   
findPlace :: [Int] -> Maybe Int
findPlace list 
   |l == 1 = Just 0 
   |otherwise = findIndex (\p -> fst p == snd p ) $ map convert $ map (\i -> splitAt i
     list ) [0..l - 1]
    where
     l :: Int
     l = length list

solution :: [Int] -> Int
solution list = case findPlace list of
 Just i -> i
 Nothing -> -1

main :: IO ( ) 
main = do
   putStrLn "Enter some integers separated by blanks!" 
   numbers <- getLine 
   print $ solution $ map read $ words numbers 
