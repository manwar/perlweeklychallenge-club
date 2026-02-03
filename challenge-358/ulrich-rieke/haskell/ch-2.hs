module Challenge358_2
   where
import Data.Char ( ord , chr ) 

convert :: Char -> Int -> Char
convert c shift 
   |(o > 64) && (o < 91) = chr o 
   |(o > 96) && (o < 123) = chr o
   |(o > 90) && (o < 97 ) = chr ( mod o 91 + 65 ) 
   |o > 122               = chr ( mod o 123 + 97 )
   where
      o :: Int
      o = ord c + shift

main :: IO ( ) 
main = do
   putStrLn "Enter a word consisting of alphabetic characters only!"
   term <- getLine
   putStrLn "Enter a positive integer!"
   numberline <- getLine
   let number = (read numberline :: Int)
   print $ map (\c -> convert c number ) term

