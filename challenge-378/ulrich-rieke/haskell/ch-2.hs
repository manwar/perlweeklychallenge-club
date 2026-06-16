module Challenge378_2
   where
import Data.Char ( ord , intToDigit )
import Data.List ( (!!) )

toNumber :: String -> Int
toNumber = read . map (\c -> intToDigit $ ord c - 97 ) 

solution :: [String] -> Bool   
solution allStrings = numbers !! 0 + numbers !! 1 == numbers !! 2
   where
      numbers :: [Int]
      numbers = map toNumber allStrings

main :: IO ( ) 
main = do
   putStrLn "Enter 3 strings consisting of English letters a to j only!"
   wordline <- getLine
   print $ solution $ words wordline
