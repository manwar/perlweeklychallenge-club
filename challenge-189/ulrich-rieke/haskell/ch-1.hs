module Challenge189
  where
import Data.List ( findIndex , sort , (!!) )

solution :: [Char] -> Char -> Char
solution characters target = case findIndex ( > target ) $ sort characters of
Just i -> characters !! i
Nothing -> ' '

main :: IO ( )
main = do
  putStrLn "Please enter some characters, separated by a blank!"
  theChars <- getLine
  putStrLn "Please enter a target character!"
  target <- getLine
  print $ solution (map head $ words theChars) ( head target)
