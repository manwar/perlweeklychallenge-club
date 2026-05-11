module Challenge372_2
   where
import Data.List ( findIndices )
import qualified Data.Set as S

solution :: String -> Int
solution str =
   let uniqueLetters = S.toList $ S.fromList str
       allLetterIndices = map (\c -> findIndices ( == c ) str ) 
        uniqueLetters 
   in if all ( (==1) . length ) allLetterIndices then -1 else maximum $ 
    map (\subli -> last subli - head subli - 1 ) $ filter ( (> 1 ) . 
     length ) allLetterIndices     

main :: IO ( )
main = do
   putStrLn "Enter a string!" 
   word <- getLine
   print $ solution word
