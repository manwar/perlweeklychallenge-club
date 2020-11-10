module Challenge085
  where
import Data.List ( subsequences )

--the basic idea : find all combinations of three, sum up each of them and
--check whether the sum is in the desired interval
solution :: [Double] -> Int
solution list = if null speciallist then 0 else 1
where
  myCondition :: Double -> Bool
  myCondition d
      |d > 1.0 && d < 2.0 = True
      |otherwise          = False
  speciallist :: [Double]
  speciallist = filter myCondition $ map sum $ filter ( (3 == ) . length)
    $ subsequences list
