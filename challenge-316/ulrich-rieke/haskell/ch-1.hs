module Challenge316
   where
import Data.List( (!!) ) 

solution :: [String] -> Bool
solution allWords =
   let allPairs = map (\i -> (last ( allWords !! i ) , head ( allWords !! ( i
        + 1 )))) [0..length allWords - 2]		  
   in all (\p -> fst p == snd p ) allPairs

main :: IO ( )
main = do
   putStrLn "Enter some words separated by whitespace!" 
   wordLine <- getLine
   print $ solution $ words wordLine
