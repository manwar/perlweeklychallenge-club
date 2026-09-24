module Challenge392
   where

isPalindrome :: String -> Bool
isPalindrome word = word == reverse word

solution :: String -> String
solution str = 
   let pairs = map (\i -> (i , take i str)) [2..length str]
       selected = filter ( isPalindrome . snd ) pairs
       maxi = if null selected then 1 else maximum $ map fst selected
   in if maxi == 1 then (reverse $ drop 1 str) ++ str else ( reverse $ drop 
       maxi str ) ++ str  

main :: IO ( )
main = do
   putStrLn "Enter a word!"
   word <- getLine
   if isPalindrome word then print word else print $ solution word
