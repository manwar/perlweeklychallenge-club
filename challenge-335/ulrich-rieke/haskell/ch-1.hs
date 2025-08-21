module Challenge355
   where
import qualified Data.Set as S
import Data.List ( sortOn , groupBy , intersperse) 

findCommonChars :: [String] -> [Char]
findCommonChars = S.toList . foldl1 S.intersection . map S.fromList

count :: Eq a => a -> [a] -> Int
count _ [] = 0 
count d (x:xs) 
   |d == x = 1 + count d xs
   |otherwise = count d xs

wordFrequencies :: String -> String -> [(Char , Int)]
wordFrequencies aWord common = map (\l -> (l , count l aWord )) $ filter
 (\l -> elem l common ) aWord

consolidate :: [[(Char , Int)]] -> [(Char , [Int])]
consolidate frequencies = 
   let consolidated = concat frequencies
       sorted = sortOn fst consolidated
       grouped = groupBy(\a b -> fst a == fst b ) sorted
   in map(\subli -> ( fst $ head subli,  map snd subli)) grouped

findFrequencies :: [String] -> [(Char , [Int])]
findFrequencies theWords = 
   let commonChars = findCommonChars theWords
       frequenciesInWords = map (\w -> wordFrequencies w commonChars ) 
        theWords
   in consolidate frequenciesInWords 

printResult :: [(Char , [Int])] -> String
printResult letterlists = intersperse ',' $ concat $ map (\p -> 
 replicate ( snd p )( fst p )) $ map (\p -> ( fst p , minimum $ snd p )) 
  $ sortOn fst letterlists

main :: IO ( )
main = do 
   putStrLn "Enter some words separated by whitespace!"
   wordline <- getLine
   print $ printResult $ findFrequencies $ words wordline

       

