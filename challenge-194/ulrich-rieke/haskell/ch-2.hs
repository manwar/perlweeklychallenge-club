module Challenge194_2
  where
import qualified Data.Set as S

count :: Eq a => a -> [a] -> Int
count el list = length $ filter ( == el ) list

solution :: String -> Int
solution input = if maxFrequency == minFrequency + 1 && ((length $ filter (\c
-> count c input == minFrequency ) uniqueLetters) == l - 1 ) then 1 else 0
where
  l :: Int
  l = length uniqueLetters
  uniqueLetters :: [Char]
  uniqueLetters = S.toList $ S.fromList input
  frequencies :: [Int]
  frequencies = map (\c -> count c input ) uniqueLetters
  maxFrequency :: Int
  maxFrequency = maximum frequencies
  minFrequency :: Int
  minFrequency = minimum frequencies
