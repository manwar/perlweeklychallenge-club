module Challenge221
  where
import qualified Data.Set as S

isGood :: String -> String -> Bool
isGood word lettersource =  S.isSubsetOf wordSet sourceSet && all
(\c -> (count c word) <= ( count c lettersource )) word
where
  wordSet :: S.Set Char
  wordSet = S.fromList word
  sourceSet :: S.Set Char
  sourceSet = S.fromList lettersource
  count :: Char -> String -> Int
  count l w = length $ filter (== l ) w

solution :: [String] -> String -> Int
solution wordlist source
  |not $ null goodlist = sum $ map length goodlist
  |otherwise          = 0
  where
    goodlist :: [String]
    goodlist = filter (\s -> isGood s source ) wordlist

main :: IO ( )
main = do
  putStrLn "Enter some words, separated by blanks!"
  wordlist <- getLine
  putStrLn "Enter a word as a source of letters!"
  lettersource <- getLine
  print $ solution ( words wordlist ) lettersource
