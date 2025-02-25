module Challenge308
   where
import qualified Data.Set as S

solution :: [String] -> [String] -> Int
solution firstWords secondWords = S.size $ S.intersection ( S.fromList
 firstWords ) ( S.fromList secondWords )

main :: IO ( )
main = do
   putStrLn "Enter some words separated by whitespace!" 
   firstLine <- getLine
   putStrLn "Enter some more words separated by whitespace!" 
   secondLine <- getLine
   print $ solution ( words firstLine ) ( words secondLine )
   
