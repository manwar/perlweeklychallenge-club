module Challenge378
   where
import qualified Data.Set as S
import Data.List ( (!!) , sort )
import Data.Char ( isDigit , digitToInt )

solution :: String -> Int
solution word = if len == 0 || len == 1 then -1 else sorted !! ( len - 2 )
   where
      allDigits :: [Char]
      allDigits = S.toList $ S.fromList $ filter isDigit word
      len       :: Int
      len       = length allDigits
      sorted    :: [Int]
      sorted    = sort $ map digitToInt allDigits

main :: IO ( )
main = do 
   putStrLn "Enter an alphanumeric string!"
   word <- getLine
   print $ solution word
