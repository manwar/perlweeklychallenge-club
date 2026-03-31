module Challenge367
   where
import Data.List ( findIndices ) 

solution :: String -> String
solution binary =
   let len = length binary
       ones = length $ findIndices ( == '1' ) binary
   in replicate ( ones - 1 ) '1' ++ replicate ( len - ones ) '0' ++ "1"

main :: IO ( )
main = do
   putStrLn "Enter a binary with at least one 1!"
   binary <- getLine
   print $ solution binary
