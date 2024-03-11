module Challenge260_2
   where
import Data.List ( sort , findIndex , permutations )
import qualified Data.Set as S 
import Data.Maybe ( fromJust )

solution :: String -> Int
solution word = (fromJust $ findIndex ( == word ) $ sort $ S.toList $
 S.fromList $ permutations word) + 1 
