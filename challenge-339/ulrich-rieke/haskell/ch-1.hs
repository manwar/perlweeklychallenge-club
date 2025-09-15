module Challenge339
   where
import Data.List ( sort , sortBy , (!!)) 

allPositive :: [Int] -> Bool
allPositive = all ((>=0) )

allNegative :: [Int] -> Bool
allNegative = all ((< 0) )

solution :: [Int] -> Int  
solution list 
   |allPositive list = (sorted !! ( l - 2 ) * sorted !! ( l - 1 )) - ( sorted !!
	               0 * sorted !! 1 )
   |allNegative list = ( sorted !! 0 * sorted !! 1 ) - ( sorted !! ( l - 2 ) * 
	               sorted !! (l - 1) )
   |otherwise        = (alterSorted !! 0 * alterSorted !! 1) - ( alterSorted !! 
	               ( l - 2 ) * alterSorted !! ( l - 1 ))
    where
     sorted :: [Int]
     sorted = sort list
     alterSorted :: [Int]
     alterSorted = sortBy(\a b -> compare ( abs a ) (abs b ) ) list
     l :: Int
     l = length list

main :: IO ( )
main = do
   putStrLn "Enter at least 4 integers separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
     
