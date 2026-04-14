module Challenge369
   where
import Data.Char ( isAlpha , toLower , toUpper )
import Data.List ( tail ) 

tag :: String -> String
tag str = 
   let allWords = words str
       sanitized = filter ( not . null ) $ map (\s -> filter isAlpha s ) allWords
       start = "#" ++ (map toLower $ head sanitized)
   in if length sanitized > 1 then start ++ ( foldl1 ( ++ ) $ map convert $ 
    tail sanitized ) else start

convert :: String -> String
convert str = [toUpper $ head str ]  ++ (map toLower $ tail str)

cut :: String -> String
cut str = if length str > 100 then take 100 str else str

main :: IO ( )
main = do
   putStrLn "Enter a sentence!"
   line <- getLine
   print $ cut $ tag line
