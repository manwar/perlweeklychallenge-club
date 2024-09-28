module Challenge288
   where

isPalindrome :: Int -> Bool
isPalindrome n = s == reverse s
 where
  s = show n
  
solution :: String -> Int
solution s = 
   let number = read s
       lowerPali = until isPalindrome pred (number - 1 )
       upperPali = until isPalindrome succ (number + 1)
       minDiff = abs( lowerPali - number )
       plusDiff = abs( upperPali - number )
   in if minDiff == plusDiff then lowerPali
    else 
      if minDiff < plusDiff then lowerPali else upperPali

main :: IO ( ) 
main = do
   putStrLn "Enter a number!"
   number <- getLine
   print $ solution number

