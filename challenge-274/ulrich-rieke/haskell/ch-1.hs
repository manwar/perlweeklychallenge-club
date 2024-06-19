module Challenge274
   where
import Data.List ( tail ) 

vowels :: [Char]
vowels = "AEIOUaeiou"

convert :: String -> Int -> String
convert s pos = if elem ( head s ) vowels then s ++ "ma" ++ replicate ( pos + 1 ) 'a'
 else tail s ++ [head s] ++ "ma" ++ replicate ( pos + 1 ) 'a' 

main :: IO ( ) 
main = do
   putStrLn "Enter a string!"
   line <- getLine
   let zipped = zip ( words line ) [0 , 1 ..]
   print $ unwords $ map (\(word, p) -> convert word p ) zipped
