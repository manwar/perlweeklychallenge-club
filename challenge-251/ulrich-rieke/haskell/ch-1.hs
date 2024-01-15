module Challenge251
   where

solution :: String -> Int
solution line = snd $ until ( null . fst ) step ( words line , 0 )
 where
  step :: ([String] , Int) -> ([String] , Int )
  step ( wordlist , sum ) = ( if condition wordlist then init $ tail 
   wordlist else [] , if condition wordlist then sum + ( read ( head 
   wordlist ++ last wordlist ) ) else sum + ( read $ head wordlist ) )
   where
    condition :: [String] -> Bool
    condition someList = length someList > 1

main :: IO ( )
main = do
   putStrLn "Enter some integers, separated by blanks!"
   numberline <- getLine
   print $ solution numberline
