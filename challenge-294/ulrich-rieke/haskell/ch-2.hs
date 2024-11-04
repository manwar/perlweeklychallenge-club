module Challenge294_2
   where
import Data.List ( sortBy , (!!) , permutations , sort , findIndices )

lexi_compare :: [Int] -> [Int] -> Ordering
lexi_compare firstList secondList = compare firstString secondString
   where
    firstString = foldl1 ( ++ ) $ map show firstList
    secondString = foldl1 (++) $ map show secondList

solution :: [Int] -> [Int]
solution numbers =
   let sorted = sort numbers
       permus = sortBy lexi_compare $ permutations sorted
       index = head $ findIndices ( == numbers ) permus
   in if index == (length permus - 1) then head permus else
    permus !! ( index + 1 )    

main :: IO ( )
main = do
   putStrLn "Enter some integers, separated by blanks!" 
   numbers <- getLine
   print $ solution $ map read $ words numbers
