module Challenge360
   where

solution :: String -> Int -> String
solution input width = if null input then replicate width '*' else
 replicate left '*' ++ input ++ replicate ( width - length input - left ) '*'
   where
      left :: Int
      left = div ( width - length input ) 2

main :: IO ( )
main = do
   putStrLn "Enter a word!"
   word <- getLine
   putStrLn "Enter a width!"
   widthline <- getLine
   print $ solution word ( read widthline )
