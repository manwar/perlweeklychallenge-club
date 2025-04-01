module Challenge315_2
   where
import Data.List ( group , sortOn , findIndices )
import Data.Maybe ( fromJust ) 
import qualified Data.Set as S   

solution :: [String] -> String -> String -> [String]
solution sentence firstword secondword =
   let increased = map ( + 1 ) $ findIndices ( == secondword ) sentence 
       uniqueWords = S.toList $ S.fromList sentence
       positions = map (\w -> ( w , findIndices ( == w ) sentence )) sentence
       zipped = zip [0 , 1 ..] sentence
       selectedPairs = filter (\p -> any (\i -> elem i increased ) $ snd p ) positions
       selectedWords = map fst $ sortOn ( head . snd ) selectedPairs
   in map head $ group selectedWords    

main :: IO ( ) 
main = do
   putStrLn "Enter a sentence!" 
   sentence <- getLine
   putStrLn "Enter a first word!" 
   firstWord <- getLine
   putStrLn "Enter a second word that follows the first one!"
   secondWord <- getLine
   print $ solution ( words sentence ) firstWord secondWord
  
