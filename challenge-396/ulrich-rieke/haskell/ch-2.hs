module Challenge396_2
   where
import Data.List ( (!!) )

solution :: [Int] -> Bool
solution numbers = 
   let differences = [numbers !! pos - (numbers !! (pos + 1)) | pos <- [0..
         length numbers - 2]]
       firstPart = takeWhile ( < 0 ) differences
       f         = length firstPart
       secondPart = takeWhile ( > 0 ) $ drop f differences
       s         = length secondPart
       thirdPart = takeWhile ( < 0 ) $ drop ( f + s ) differences
       t         = length thirdPart
   in if elem 0 differences then False else and[ f /= 0 , s /= 0 , 
    t /= 0 , f + s + t == length differences]

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks!"
   line <- getLine
   print $ solution $ map read $ words line
