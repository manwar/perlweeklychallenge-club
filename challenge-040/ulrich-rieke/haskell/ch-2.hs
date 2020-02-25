module Challenge040_2
  where
import qualified Data.Set as S
import Data.Function ( on )
import Data.List( (!! ), sort , sortBy )

convert :: [Int] -> [Int] -> [Int]
convert list indices =
  let orderedIndices = sort indices
      sublist = map (\i -> list !! i ) orderedIndices
      sortedSublist = sort sublist
      stableIndices = (S.fromList [0..length list - 1]) S.\\ (S.fromList
        orderedIndices )
      stableElements = map (\i -> list !! i) $ S.toList stableIndices
      stablePairs = zip (S.toList stableIndices) stableElements
      reorderedPairs = zip orderedIndices sortedSublist
  in map snd $ sortBy ( compare `on` fst ) ( stablePairs ++ reorderedPairs )
