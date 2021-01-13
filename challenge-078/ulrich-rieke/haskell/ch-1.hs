module Challenge078
  where

solution :: [Int] -> [Int]
solution list = (map snd $ filter (\p -> snd p > ( maximum $
drop ( fst p ) list )) $ zip [1,2 .. length list - 1] list ) ++
  [ last list ]
