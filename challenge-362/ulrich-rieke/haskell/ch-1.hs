module Challenge362
   where

solution :: String -> String
solution = foldl1 ( ++ ) . map(\p -> replicate ( fst p ) ( snd p ) ) . zip [1 , 2 ..]

main :: IO ( )
main = do
   putStrLn "Please enter a word!"
   line <- getLine
   print $ solution line
