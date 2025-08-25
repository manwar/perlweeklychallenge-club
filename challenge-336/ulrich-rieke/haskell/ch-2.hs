module Challenge336_2
   where
import Data.List ( (!!) ) 
import Data.Char ( isDigit ) 

convert :: String -> Int
convert str = if head str == '-' then (read ( drop 1 str )) * (-1) else read str

addNumber :: [Int] -> String -> [Int]
addNumber list str 
   |str == "C" = take ( l - 1 ) list
   |str == "D" = list ++ [ (last list) * 2 ]
   |str == "+" =  list ++ [ (list !! ( l - 2 )) + list !! ( l - 1 ) ]
   |otherwise = list ++ [ convert str ]
    where
     l :: Int
     l = length list

solution :: String -> Int
solution input = 
   let theWords = words input 
       (firstPart , secondPart ) = span (\s -> isDigit ( head s ) || head s == 
	     '-' ) theWords
       startnumbers = map convert firstPart
   in sum $ foldl addNumber startnumbers secondPart   

main :: IO ( ) 
main = do
   putStrLn "Enter some integers , C , D or + separated by blanks!" 
   inputline <- getLine
   print $ solution inputline
