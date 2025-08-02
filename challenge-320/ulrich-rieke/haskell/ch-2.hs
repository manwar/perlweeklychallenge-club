module Challenge320_2
   where
import Data.Char ( digitToInt ) 

solution :: [Int] -> Int
solution list = abs ( numbersum - allDigitSum )
   where
    numbersum :: Int
    numbersum = sum list
    allDigitSum :: Int
    allDigitSum = sum $ map ( sum . map digitToInt . show ) list

main :: IO ( ) 
main = do
   putStrLn "Enter some positive integers separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline

