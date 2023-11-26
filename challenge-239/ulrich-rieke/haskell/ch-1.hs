module Challenge239
   where

main :: IO ( ) 
main = do
   putStrLn "Please enter some strings separated by blanks!" 
   firstStrings <- getLine
   putStrLn "Enter some more strings separated by blanks!"
   secondStrings <- getLine
   let firstWord = foldl1 ( ++ ) $ words firstStrings
       secondWord = foldl1 ( ++ ) $ words secondStrings
   if firstWord == secondWord then print "true" else print "false"    
