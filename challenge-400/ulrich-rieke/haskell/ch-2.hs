module Challenge400_2
   where

stringDifference :: String -> String -> Int
stringDifference str1 str2 = length $ filter (\p -> fst p /= snd p ) $
 zip str1 str2

solution :: String -> String -> [String] -> Int
solution start end genebank =
   let mutations = stringDifference start end
       allDifferences = map ( stringDifference start ) genebank
   in if start == end then 0
      else
         if notElem end genebank then -1
         else 
            if all (flip elem allDifferences ) [1..mutations] then mutations
            else -1

main :: IO ( )
main = do
   putStrLn "Enter a start genome!"
   start <- getLine
   putStrLn "Enter an end genome of equal length!"
   end <- getLine
   putStrLn "Enter a bank of genomes of equal length!"
   bank <- getLine
   print $ solution start end ( words bank )
