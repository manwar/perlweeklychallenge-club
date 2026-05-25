module Challenge375
   where
import qualified Data.Set as S
import Data.List ( findIndices )

findFrequencies :: [String] -> [(String , Int)]
findFrequencies allWords = map (\w -> (w , length $ findIndices ( == w ) allWords))
   $ S.toList $ S.fromList allWords

solution :: [String] -> [String] -> Int
solution firstWords secondWords =
   let firstFrequencies = findFrequencies firstWords
       secondFrequencies = findFrequencies secondWords
   in length $ filter (\p -> elem p secondFrequencies && (snd p == 1))
    firstFrequencies    

main :: IO ( )
main = do
   putStrLn "Enter some strings separated by blanks!"
   firstWords <- getLine
   putStrLn "Enter some more strings separated by blanks!"
   secondWords <- getLine
   print $ solution ( words firstWords ) ( words secondWords )
