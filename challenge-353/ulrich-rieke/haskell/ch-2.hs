module Challenge353_2
   where
import Data.List ( (!!) )

allowed :: [Char]
allowed = ['a' , 'b' .. 'z'] ++ ['0' , '1' .. '9'] ++ ['A' , 'B' .. 'Z'] ++ "_"

categories :: [String]
categories = ["pharmacy" , "restaurant" , "grocery" , "electronics"]

enterLines :: IO [String]
enterLines = do
   line <- getLine
   if null line then return []
   else (line : ) <$> enterLines  

solution :: [String] -> [String] -> [String] -> [Bool]
solution codes names status = map (\i -> and [all( flip elem allowed ) $ codes !! i , 
 elem ( names !! i ) categories , status !! i == "true"] ) [0..length codes - 1]

main :: IO ( ) 
main = do
   putStrLn "Enter codes , <enter> to end!"
   codelines <- enterLines
   putStrLn "Enter names , <enter> to end!"
   namelines <- enterLines
   putStrLn "Enter status codes true or false , <enter> to end!"
   statuslines <- enterLines
   print $ solution codelines namelines statuslines 

