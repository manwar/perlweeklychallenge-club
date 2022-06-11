module Challenge162
  where
import Data.Char ( digitToInt )
import Data.List.Split ( splitOn )

askForISBN :: IO (String , String)
askForISBN = do
  putStrLn "Enter an ISBN string, with 12 digits only!"
  isbn <- getLine
  let numberstrings = splitOn "-" isbn
      totalNumber = foldl1 ( ++ ) numberstrings
  if length totalNumber == 12
  then return (isbn , totalNumber)
  else do
      askForISBN

multipliers :: [Int]
multipliers = take 12 $ cycle [1 , 3 ]

findDigitStr :: String -> String
findDigitStr numberstring = if (10 - theSum) /= 0 then show (10 - theSum) else "0"
where
  theSum :: Int
  theSum = mod (sum $ zipWith ( + ) ( map digitToInt numberstring ) multipliers) 10

main :: IO ( )
main = do
  ( isbn , numbers ) <- askForISBN
  putStrLn ("The complete ISBN is " ++ isbn ++ ( findDigitStr numbers) ++ " !")
