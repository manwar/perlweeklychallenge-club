import Data.List

groups :: Int -> String -> [String]
groups groupLen = takeWhile (not . null) . unfoldr (Just . splitAt groupLen)

sumEm :: [String] -> [String]
sumEm = map (show . sum . map (\y -> read [y]))

groupDigitSum :: Int -> String -> String
groupDigitSum 0 _  = ""
groupDigitSum _ "" = ""
groupDigitSum groupLen input
  | length input > groupLen =
      groupDigitSum groupLen (concat $ sumEm $ groups groupLen input)
  | otherwise = input
