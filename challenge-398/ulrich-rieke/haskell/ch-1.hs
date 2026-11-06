module Challenge398
   where

solution :: [Int] -> Int
solution numbers =
   let selected = filter (\i -> mod i 2 == 0 && mod i 3 == 0) numbers
       l        = length selected
   in if l == 0 then 0 else round (( fromIntegral $ sum selected ) /
         (fromIntegral l )) 

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks!" 
   line <- getLine
   print $ solution $ map read $ words line 
