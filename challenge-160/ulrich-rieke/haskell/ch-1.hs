module Challenge160
  where
import qualified Data.Map as M
import Data.List.Split ( divvy )
import Data.Maybe ( fromJust )

numberWords :: M.Map String String
numberWords = M.fromList [("1" , "one") , ("2", "two") , ("3" , "three") , ("4", "four") ,
("5", "five") , ("6" , "six") , ("7" , "seven") , ( "8" , "eight") , ("9" , "nine")]

findNumberString :: String -> String
findNumberString num =
  case M.lookup ( show $ length num ) numberWords of
      Nothing -> ""
      Just s -> s

solution :: String -> String
solution number
  |null list = number ++ " is four, four is magic."
  |length list == 1 = number ++ " is four, four is magic."
  |otherwise = (foldl1 ( ++ ) $ map (\li -> head li ++ " is " ++ last li ++ ", ")
    $ divvy 2 1 list) ++ last list ++ " is four, four is magic."
  where
      list :: [String]
      list = takeWhile ( /= "four" ) $ iterate findNumberString number

askForInput :: IO Int
askForInput = do
  putStrLn "Enter a number in the range of 1 to 9!"
  number <- getLine
  let num = read number
  if  (num > 0) && (num < 10) then return num
  else do
      askForInput

main :: IO ( )
main = do
  num <- askForInput
  putStrLn $ solution $ fromJust $ M.lookup (show num) numberWords
