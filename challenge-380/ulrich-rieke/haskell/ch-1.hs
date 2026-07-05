module Challenge380
   where
import qualified Data.Set as S
import Data.List ( findIndices ) 

vowels :: String
vowels = "aeiouAEIOU"

solution :: String -> Int
solution str =
   let unique_vowels = S.toList $ S.fromList $ filter ( flip elem vowels ) str
       unique_consos = S.toList $ S.fromList $ filter ( flip notElem vowels ) str
       vowelmax = if not $ null unique_vowels then maximum $ map (\c -> length $ 
             findIndices ( == c ) str ) unique_vowels else 0
       consomax = if not $ null unique_consos then maximum $ map (\c -> length $
             findIndices ( == c ) str ) unique_consos else 0
   in vowelmax + consomax

main :: IO ( )
main = do
   putStrLn "Enter a string consisting of English letters only!"
   word <- getLine
   print $ solution word
