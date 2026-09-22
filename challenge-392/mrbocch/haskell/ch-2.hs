import Data.Function

(.:) :: (c -> d) -> (a -> b -> c) -> a -> b -> d
(f .: g) a b = f (g a b)

wordsLengthProduct :: [String] -> Int 
wordsLengthProduct xs = pairs xs
                      & filter (uncurry noCommon)
                      & map (\(a,b) -> length a * length b)
                      & maximumOr 0 

  where
    noCommon :: Eq a => [a] -> [a] -> Bool
    noCommon =  and .: zipWith (/=)

    pairs :: [a] -> [(a, a)]
    pairs [] = []
    pairs (x:xs) = map (, x) xs ++ pairs xs

    maximumOr :: Ord a => a -> [a] -> a
    maximumOr other [] = other 
    maximumOr _ xs     = maximum xs 

main :: IO()
main = do
  print $ wordsLengthProduct ["a", "ab", "abc", "d", "de", "def"]   == 9 
  print $ wordsLengthProduct ["a", "aa", "aaa", "aaaa" ]            == 0
  print $ wordsLengthProduct ["meet", "app", "code", "sky", "bold"] == 16 
  print $ wordsLengthProduct ["a", "ab", "abc", "abcd", "efghi"]    == 20 
  print $ wordsLengthProduct ["xyz", "w", "abcdefg", "hij"]         == 21 

