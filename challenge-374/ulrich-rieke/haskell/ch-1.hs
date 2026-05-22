module Challenge374
   where
import qualified Data.Set as S

condition :: String -> Bool
condition str = S.fromList str == S.fromList "aeiou"

solution :: String -> [String]
solution word = 
   let l = length word
       substrings = if l < 5 then [] else [take ( to - from ) $ drop from word |
        from <- [0..l - 5] , to <- [from + 5 .. l]]
   in if null substrings then [] else filter condition substrings

main :: IO ( )
main = do
   putStrLn "Enter a string!"
   word <- getLine
   print $ solution word

