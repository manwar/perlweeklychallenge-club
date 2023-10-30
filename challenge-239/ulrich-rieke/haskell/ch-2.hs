module Challenge239_2
   where
import qualified Data.Set as S

isConsistent :: String -> String -> Bool
isConsistent str allowed = all (\c -> elem c allowed ) str

solution :: String -> String -> Int
solution input allowed = length $ filter (\s -> isConsistent s allowed ) $ 
 words input

main :: IO ( ) 
main = do
   putStrLn "Please enter some strings, separated by blanks!" 
   strings <- getLine
   putStrLn "Enter an allowed word!"
   allowed <- getLine
   --consider only unique characters in allowed
   let set_allowed = S.toList $ S.fromList allowed
   print $ solution strings set_allowed
