module Challenge310_2
   where
import Data.List ( partition , sort , sortBy )

mySplit :: [Int] -> ([Int] , [Int])
mySplit list =
   let parts = partition ( even . fst ) $ zip [0 , 1 ..] list   
   in ( map snd $ fst parts , map snd $ snd parts )

sortParts :: ([Int] , [Int]) -> ([Int] , [Int]) 
sortParts ( evens , odds ) = ( sort evens , sortBy mySorter odds )
 where
  mySorter :: Int -> Int -> Ordering
  mySorter a b
    |a > b = LT
    |a == b = EQ
    |a < b = GT

merge :: ([Int] , [Int]) -> [Int]
merge ( evens , odds )
   |even ( length evens + length odds ) = foldl1 ( ++ ) $ map (\p -> [fst p ,
     snd p]) $ zip evens odds
   |otherwise = (foldl1 ( ++ ) $ map (\p -> [fst p , snd p] ) $ zip evens odds)
    ++ [last evens] --there is one unmatched element in evens that was not zipped

solution :: [Int] -> [Int]
solution list = 
   let splitParts = mySplit list
       sortedParts = sortParts splitParts
   in merge sortedParts

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks!" 
   numberline <- getLine
   print $ solution $ map read $ words numberline

