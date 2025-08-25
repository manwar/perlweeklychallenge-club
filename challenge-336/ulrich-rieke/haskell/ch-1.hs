module Challenge336
   where
import Data.List( group , findIndices, sortOn ) 
import qualified Data.Set as S

makePairs :: [Int] -> [(Int , Int)]   
makePairs list = map (\i -> ( i , length $ findIndices ( == i ) list )) $ S.toList
 $ S.fromList list

checkCondition :: [(Int , Int)] -> Bool
checkCondition frequencies =
   let sorted = sortOn snd frequencies
       mini = snd $ head sorted
       l    = length sorted
   in if l == 1 then mini > 1 else (all (\p -> snd p `mod` mini == 0 ) $ drop 1  
    sorted) && ( mini > 1 )

main :: IO ( ) 
main = do
   putStrLn "Enter some integers separated by blanks!" 
   numberline <- getLine
   print $ checkCondition $ makePairs $ map read $ words numberline
