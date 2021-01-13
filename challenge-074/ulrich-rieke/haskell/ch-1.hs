module Challenge074
  where
import Data.List( sortOn , group , sort )

solution :: [Int] -> Int
solution list
  |maxFreq > floor ((fromIntegral $ length list ) / 2 ) = head $ last sortedList
  |otherwise = -1
  where
      sortedList = sortOn length $ group $ sort list
      maxFreq    = length $ last sortedList
