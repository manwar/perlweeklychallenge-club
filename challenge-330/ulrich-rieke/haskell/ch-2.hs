module Challenge330_2
   where
import Data.Char ( toUpper , toLower )
import Data.List ( tail ) 

convert :: String -> String
convert str = if length str < 3 then map toLower str else [toUpper $ head 
 str] ++ ( map toLower $ tail str )

solution :: String -> String
solution = unwords . map convert . words

main :: IO ( )
main = do
   putStrLn "Enter a sentence with words separated by space!" 
   line <- getLine
   print $ solution line
