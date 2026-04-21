import Data.Function

groupDivision :: String -> Int -> Char -> [String]
groupDivision str size filler = chunksOf size str
                                & fLast fill
    where
      chunksOf :: Int -> String -> [String]
      chunksOf _ [] = []
      chunksOf n xs = take n xs : chunksOf n (drop n xs)

      fLast :: (a -> a) -> [a] -> [a]
      fLast _ []     = []
      fLast f [x]    = [f x]
      fLast f (x:xs) = x : fLast f xs

      fill :: String -> String
      fill s = s ++ replicate (size - length s) filler

main :: IO ()
main = do
  print $ groupDivision "RakuPerl" 4 '*'   == ["Raku", "Perl"]
  print $ groupDivision "Python" 5 '0'     == ["Pytho", "n0000"]
  print $ groupDivision "12345" 3 'x'      == ["123", "45x"]
  print $ groupDivision "HelloWorld" 3 '_' == ["Hel", "loW", "orl", "d__"]
  print $ groupDivision "AI" 5 '!'         == ["AI!!!"]
