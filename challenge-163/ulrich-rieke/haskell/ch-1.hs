module Challenge163
  where
import Data.List( subsequences , nub)
import Data.Bits( (.&.) )

solution :: [Int] -> Int
solution list = sum $ map (\li -> head li .&. last li ) $ nub $ filter
( (== 2 ) . length ) $ subsequences list
