module Challenge174
  where
import Data.Char ( digitToInt )

isDisarium :: Int -> Bool
isDisarium n = ( sum $ map (\p -> (snd p) ^ ( fst p ) ) $ zip [1 , 2 ..] (map digitToInt $ show n)) == n

solution :: [Int]
solution = take 19 $ filter isDisarium [0 , 1 ..]
