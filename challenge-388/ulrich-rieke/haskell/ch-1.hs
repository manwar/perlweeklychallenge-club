module Challenge388
   where
import Data.List ( sort , permutations , findIndices)
import qualified Data.Set as S

condition :: String -> Bool
condition str = 
   let l = length str
       allSubstrings = map (\i -> take i str ) [1..l]
   in all (\s -> (length $ findIndices ( == 'U' ) s ) >= ( length $
            findIndices ( == 'D' ) s )) allSubstrings
           

createString :: Int -> String
createString n = take ( 2 * n ) $ cycle "UD"

solution :: Int -> [String]   
solution n = if n == 0 then [] else sort $ S.toList $ S.fromList $ filter condition
 $ permutations created 
   where
      created :: String
      created = createString n

main :: IO ( ) 
main = do
   putStrLn "Enter a positive integer!"
   number <- getLine
   print $ solution ( read number :: Int )
