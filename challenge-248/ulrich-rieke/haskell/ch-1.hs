module Challenge248
   where

solution :: String -> Char -> [Int]
solution stri letter = map (\i -> minimum $ map (\d -> abs ( d - i ) ) positions )
 [0..length stri - 1]
 where
  positions :: [Int]
  positions = map snd $ filter ((letter == ) . fst ) $ zip stri [0, 1..]

main :: IO ( )
main = do 
   putStrLn "Please enter a string and a letter from the string, separated by a blank!"
   input <- getLine ;
   let searchstring = head $ words input
       char_wanted = head $ last $ words input
   print $ solution searchstring char_wanted    
