module Challenge250_2
   where
import Data.Char ( isLetter )

convert :: String -> Int
convert s = if any isLetter s then length s else read s

solution :: String -> Int
solution =  maximum . map convert . words

main :: IO ( )
main = do
   putStrLn "Please enter some strings, separated by blanks!"
   strings <- getLine
   print $ solution strings
