import Data.Function

listDivision :: [a] -> Int -> Maybe [[a]]
listDivision l n
  | n <= 0   = Nothing
  | lenl < n = Nothing
  | otherwise = Just $ groupA ++ groupB
    where
      groups :: [a] -> Int -> [[a]]
      groups [] _ = []
      groups xs n = take n xs : groups (drop n xs) n

      lenl = length l
      groupCountA = mod lenl n
      groupSizeB = quot lenl n
      groupSizeA = groupSizeB + 1

      totalA = groupCountA * groupSizeA

      groupA = groups (take totalA l) groupSizeA
      groupB = groups (drop totalA l) groupSizeB

main :: IO ()
main = do
    print $ listDivision [1,2,3,4,5] 2                     == Just [[1,2,3], [4,5]]
    print $ listDivision [1,2,3,4,5,6] 3                   == Just [[1,2], [3,4], [5,6]]
    print $ listDivision [1,2,3] 2                         == Just [[1,2], [3]]
    print $ listDivision [1,2,3,4,5,6,7,8,9,10] 5          == Just [[1,2], [3,4], [5,6], [7,8], [9,10]]
    print $ listDivision [1,2,3] 4                         == Nothing
    print $ listDivision [72,57,89,55,36,84,10,95,99,35] 7 == Just [[72,57], [89,55], [36,84], [10], [95], [99], [35]]
