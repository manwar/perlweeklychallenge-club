module Challenge065
  where
import Data.Char ( digitToInt )

findNumbers :: Int -> Int -> [Int]
findNumbers digits digitsum = [ d | d <- [lowest..highest] ,
(sum $ map digitToInt $ show d) == digitsum]
where
  lowest = read ("1" ++ ( take ( digits - 1 ) $ repeat '0'))
  highest = read ( "9" ++ ( take ( digits - 1 ) $ repeat '9' ))
