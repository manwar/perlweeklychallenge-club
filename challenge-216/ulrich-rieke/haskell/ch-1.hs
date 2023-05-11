module Challenge216
  where
import Data.Char ( toLower , isAlpha)
import qualified Data.Set as S

solution :: [String] -> String -> [String]
solution theWords registration = filter (\w -> regiset `S.isSubsetOf` (S.fromList
w )) theWords
where
  regiset = S.fromList registration

main :: IO ( )
main = do
  putStrLn "Please enter some words, separated by blanks!"
  theWords <- getLine
  putStrLn "Please enter a registration number in 2 parts!"
  regiline <- getLine
  let allWords = words theWords
      relevant_word = map toLower $ filter isAlpha $ foldl1 ( ++ ) $ words regiline
  print $ solution allWords relevant_word
