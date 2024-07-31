module Challenge280
   where
import qualified Data.Set as S
import Data.List ( findIndices , sortOn )

solution :: String -> Char
solution s = if any ( (>= 2) . length . snd ) indices then fst $ head $ 
 sortOn ( last . snd ) $ filter ( (> 1 ) . length . snd ) indices else ' '
 where
  indices = map (\c -> (c , findIndices (== c ) s ) ) $ S.toList $
   S.fromList s

main :: IO ( )
main = do
   putStrLn "Enter a word of lowercase letters only!"
   line <- getLine
   print $ solution line


