module Challenge345_2
   where
import Data.List ( (!!) )

--find the indices of all -1 ; then group them and count the elements of
--every subgroup 
findCountedNegatives :: [Int] -> [(Int , Int)]
findCountedNegatives list = 
   let zipped = zip list [0, 1 ..]
       negatives = filter ( (== -1) . fst ) zipped
       negativeGroups = groupAsc negatives
       countedGroups = map (\subli -> zip [0 , 1 ..] (map snd subli) )
        negativeGroups
   in concat countedGroups

groupAsc :: [(Int,Int)] -> [[(Int , Int)]]
groupAsc [] = []
groupAsc (x:xs) = go [x] xs
  where
    go current [] = [current]
    go current@(cLast:_) (y:ys)
      | snd y == snd (last current) + 1 = go (current ++ [y]) ys
      | otherwise              = current : go [y] ys
   
--for every -1 find the corresponding number by looking for all positive
--numbers left of a -1 , reversing them and taking the right integer
findNumber :: (Int , Int ) -> [Int] -> Int
findNumber pair list =
   let positives = filter ( > 0 ) $ take ( snd pair ) list
   in if ( fst pair ) < length positives then ( reverse positives ) !! 
    (fst pair) else -1

solution :: [Int] -> [Int]
solution list =
   let countedNegatives = findCountedNegatives list
   in map ( flip findNumber list ) countedNegatives

main :: IO ( ) 
main = do
   putStrLn "Enter some positive numbers and -1 separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
