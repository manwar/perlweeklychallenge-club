module Challenge377_2
   where
import Data.List ( isPrefixOf , isSuffixOf , (!!) ) 

solution :: [String] -> Int
solution strings =
   let l        = length strings
       allPairs = [(strings !! i , strings !! j) | i <- [0..l - 2] , 
        j <- [i + 1 .. l - 1]]
   in length $ filter (\p -> isPrefixOf ( fst p ) ( snd p ) && (
            isSuffixOf ( fst p ) ( snd p ) )) allPairs

main :: IO ( )
main = do
   putStrLn "Enter some strings separated by blanks!"
   line <- getLine
   print $ solution $ words line
