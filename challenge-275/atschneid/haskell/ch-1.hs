import Data.List ( words )
import Data.Char ( toUpper, toLower )

charInStringAnyCase :: Char -> String -> Bool
charInStringAnyCase c s = or [elem (toUpper c) s, elem (toLower c) s]

checkLettersInString :: [Char] -> String -> Bool
checkLettersInString cs s = or $ map (\c -> charInStringAnyCase c s) cs

checkListForChars :: [Char] -> [String] -> [Bool]
checkListForChars cs sl =
  let f = checkLettersInString cs
  in map f sl

checkBrokenKey :: [Char] -> String -> Int
checkBrokenKey cs s =
  let sl = words s
      bool_list = checkListForChars cs sl
  in length $ filter not bool_list

string_chars = [
  ( "Perl Weekly Challenge", ['l', 'a'] ),
  ( "Perl and Raku", ['a'] ),
  ( "Well done Team PWC", ['l', 'o'] ),
  ( "The joys of polyglottism", ['T'] )
  ]
bkstring = map (\ p -> checkBrokenKey (snd p) (fst p)) string_chars
main = putStrLn $ show bkstring 
