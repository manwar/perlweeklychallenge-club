import Data.Function
import qualified Data.Map as Map

largestSubstring :: String -> Int
largestSubstring s = map (\x -> (firstIndx s x, lastIndx s x)) (uniq s)
                   & map diff
                   & maximum
  where
    -- a silly way of implementing uniq
    uniq :: Ord a => [a] -> [a]
    uniq xs = map (\x -> (x, 1)) xs
            & Map.fromList
            & Map.keys

    diff :: (Int, Int) -> Int
    diff (a,b) = b - (a+1)

    firstIndx :: String -> Char -> Int
    firstIndx s c = zip s [1..]
                  & filter ((== c) . fst)
                  & head
                  & snd

    lastIndx :: String -> Char -> Int
    lastIndx s c = zip s [1..]
                 & filter ((== c) . fst)
                 & last
                 & snd

main :: IO ()
main = do
  print $ largestSubstring "aaaaa"    == 3
  print $ largestSubstring "abcdeba"  == 5
  print $ largestSubstring "abbc"     == 0
  print $ largestSubstring "abcaacbc" == 4
  print $ largestSubstring "laptop"   == 2
  print $ largestSubstring "abcdefg"  == (-1)
