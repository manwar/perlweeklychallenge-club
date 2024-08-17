module Challenge280
   where
import qualified Data.Set as S
import Data.List ( findIndices , sortOn , (!!) )

--the solution is as follows : pair up every character with the list
--of indices where it can be found in the string. We use unique 
--characters for that. Then , we look for the character that occurs 
--more than once in the string by filtering all pairs that have more
--than one element in the associated list. The character we look for 
--is the one with the smallest index number at position 2 corresponding
--to index 1 , so we sort on that index

solution :: String -> Char
solution s = if any ( (>= 2) . length . snd ) indices then fst $ head $ 
 sortOn (\p -> (snd p) !! 1 ) $ filter ( (> 1 ) . length . snd ) indices
  else ' '
  where
   indices = map (\c -> (c , findIndices (== c ) s ) ) $ S.toList $
    S.fromList s

main :: IO ( )
main = do
   putStrLn "Enter a word of lowercase letters only!"
   line <- getLine
   print $ solution line
