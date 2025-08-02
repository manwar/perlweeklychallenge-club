module Challenge314
   where

findGreatestCommonStart :: String -> String -> String
findGreatestCommonStart "" s2 = ""
findGreatestCommonStart s1 "" = ""
findGreatestCommonStart (x:xs) (y:ys)
   |x == y = [x] ++ findGreatestCommonStart xs ys
   |otherwise = "" 
      
solution :: [String] -> Int
solution list = 
   let longestCommon = foldl1 findGreatestCommonStart list
   in if null longestCommon then -1 else sum $ map (\s -> length s - ( length 
    longestCommon )) list

main :: IO ( )
main = do
   putStrLn "Enter 3 words separated by blanks!"
   allWords <- getLine
   print $ solution $ words allWords
