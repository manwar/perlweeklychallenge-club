import Data.Char (isAlpha)
mapAdjacentR :: (a -> a -> b) -> [a] -> [b]
mapAdjacentR f l = map (\p -> f (snd p) (fst p)) $ zip l (tail l)

chunkListBySteps :: [Int] -> [a] -> [[a]]
chunkListBySteps _ [] = []
chunkListBySteps [] l = [l]
chunkListBySteps (s : xs) l = (take s l) : chunkListBySteps xs (drop s l)

chunkListBy :: (a -> Bool) -> [a] -> [[a]]
chunkListBy _ [] = []
chunkListBy f l =
  let bool_list = map (f) l
      changepoints = mapAdjacentR (/=) bool_list
      change_indices = map fst $ filter snd $ zip [1 ..] changepoints
      change_steps = [change_indices !! 0] ++ mapAdjacentR (-) change_indices
   in chunkListBySteps change_steps l
