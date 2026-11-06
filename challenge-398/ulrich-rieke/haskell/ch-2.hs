module Challenge398_2
   where
import Data.Char ( ord )
import Data.List ( (!!) )
import qualified Data.Set as S

wordDifferences :: String -> [Int]
wordDifferences str = [(ord $ str !! i) - (ord $ str !! ( i - 1 ))| 
 i <- [1, 2.. length str - 1]]

count :: Eq a => a -> [a] -> Int
count _ [] = 0 
count d (x:xs) 
   |d == x = 1 + count d xs
   |otherwise = count d xs

solution :: [String] -> String
solution allWords =
   let worddiffs = map (\s -> (s , wordDifferences s)) allWords
       theDiffs = map snd worddiffs 
       allDiffsUnique = S.toList $ S.fromList theDiffs
       counted = map (\diff -> (diff , count diff theDiffs ) )
        allDiffsUnique
       onlyOnce = filter ( (== 1) . snd ) counted     
   in head $ map fst $ filter (\p -> elem ( snd p ) $ map fst onlyOnce )
    worddiffs 

main :: IO ( )
main = do
   putStrLn "Enter some words with equal length > 1!" 
   line <- getLine
   print $ solution $ words line
