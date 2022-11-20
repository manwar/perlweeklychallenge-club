module Challenge191_2
  where
import Data.List ( permutations )

isCute :: [Int] -> Bool
isCute list = all (\p -> (mod ( fst p ) ( snd p ) == 0) ||( mod ( snd p ) ( fst p )
== 0) ) $ zip [1 , 2 ..] list

solution :: Int -> Int
solution n = length $ filter isCute $ permutations [1..n]

keepAskingForInput :: IO Int
keepAskingForInput = do
  putStrLn "Please enter a number greater than 0 and up to and including 15!"
  number <- getLine
  let num = read number
  if num > 0 && num < 16
  then
      return num
      else keepAskingForInput

main :: IO ( )
main = do
  number <- keepAskingForInput
  print $ solution number
