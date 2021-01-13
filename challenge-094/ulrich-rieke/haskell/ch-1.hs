module Challenge094
  where
import Data.List ( sort )
import qualified Data.Set as S

findAnagrams :: String -> [String] -> [String]
findAnagrams combi list = filter( (combi == ). sort ) list

allCombis :: [String] -> [String]
allCombis list = S.toList $ S.fromList $ map sort list

solution :: [String] -> [[String]]
solution list = map(\w -> findAnagrams w list ) theCombis
  where
      theCombis :: [String]
      theCombis = allCombis list
