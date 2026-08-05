module Challenge385_2
   where

findLetterNumbers :: String -> [(Int , Char)]
findLetterNumbers str = foldl f [(0 , '0' )] str
   where
      f :: [(Int , Char)] -> Char -> [(Int , Char)]
      f list c 
         |c == '(' = list ++ [((fst $ last list) + 1 , c)]
         |otherwise = list ++ [((fst $ last list) - 1 , c)]

solution :: String -> String
solution str = map snd $ filter (\p -> (fst p /= 1 && ( snd p == '(' )) ||
 ( fst p  /= 0 && ( snd p == ')' ))) $ findLetterNumbers str 
 
main :: IO ( ) 
main = do
   putStrLn "Enter a valid parentheses string!"
   parens <- getLine
   print $ solution parens
