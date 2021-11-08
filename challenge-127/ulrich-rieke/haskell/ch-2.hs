module Challenge127_2
  where
import qualified Data.Set as S

solution :: [(Int, Int)] -> [(Int, Int)]
solution list = map snd $ filter myCondition $ zip [1 , 2 .. ] $ tail list
where
  myCondition :: (Int , (Int , Int)) -> Bool
  myCondition aPair = any (\s -> not $ S.null $ S.intersection s ( toSet $
  snd aPair ) ) $ map toSet $ take ( fst aPair ) list
  toSet :: (Int , Int) -> S.Set Int
  toSet pair = S.fromList [fst pair .. snd pair]
