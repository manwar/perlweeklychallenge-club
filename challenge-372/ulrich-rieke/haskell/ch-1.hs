module Challenge372
   where
import Data.Char ( isSpace ) 
import Data.List ( init )

format :: String -> String
format input = 
   let totalspaces = length $ filter isSpace input
       allWords = words input
       len      = length allWords 
       gapspace = if len == 1 then 0 else div totalspaces ( len - 1 ) 
   in if len == 1 then head allWords ++ replicate totalspaces ' ' else 
    (foldl1 ( ++ ) $ map ( convert gapspace ) $ init allWords)
     ++ last allWords ++ replicate ( totalspaces - gapspace * ( len - 1 ) ) ' '

convert :: Int -> String -> String
convert gap word = word ++ replicate gap ' '

main :: IO ( )
main = do
   putStrLn "Enter a text with words surrounded by spaces!"
   line <- getLine
   print $ format line
