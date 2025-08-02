module Challenge261
   where
import Data.Char( digitToInt )

solution :: [Int] -> Int
solution list = abs ( elementsums - digitsums )
 where
  elementsums :: Int
  elementsums = sum list
  digitsums :: Int
  digitsums = sum $ map ( sum . map digitToInt . show ) list

main :: IO ( )
main = do
   putStrLn "Enter some integers, separated by blanks!" 
   numbers <- getLine
   print $ solution ( map read $ words numbers )
