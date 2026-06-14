module Challenge377
   where
import Data.List.Split ( divvy )

solution :: String -> Bool
solution word =
   let backward_pairs = divvy 2 1 $ reverse word
   in any ( flip elem backward_pairs ) $ divvy 2 1 word

main :: IO ( )
main = do
   putStrLn "Enter a word!"
   word <- getLine
   print $ solution word
