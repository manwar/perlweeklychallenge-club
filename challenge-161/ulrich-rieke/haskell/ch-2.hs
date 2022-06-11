module Challenge161_2
  where
import Data.List ( sort, sortOn )

nodups :: Eq a => [a] -> Bool
nodups [] = True
nodups (x:xs) = (not $ elem x xs) && nodups xs

main :: IO ( )
main = do
  allWordsInOne <- readFile "dictionary.txt"
  let allWords = words allWordsInOne
      oneLetterPerWord = sort $ filter nodups allWords
      wordsByStartLetter = map (\l -> sortOn length $ filter ( ( == l ) . head )
        oneLetterPerWord ) ['a' .. 'z']
  putStrLn "One word per letter, shortest , every letter only once in word!"
  print $ fmap head wordsByStartLetter
  putStrLn "One word per letter , longest , every letter once in word!"
  print $ fmap last wordsByStartLetter
