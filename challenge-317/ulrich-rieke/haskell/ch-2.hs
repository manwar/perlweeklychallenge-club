module Challenge317_2
   where
import Data.List( (!!) ) 

solution :: String -> String -> Bool
solution firststr secondstr = and [length different == 2 , (fst $ different !! 0)
 == (snd $ different !! 1) , (snd $ different !! 0) == (fst $ different !! 1)]
  where different = filter (\p -> fst p /= snd p ) $ zip firststr secondstr

main :: IO ( ) 
main = do 
   putStrLn "Enter a line with 2 strings!" 
   line <- getLine
   let [firstWord , secondWord] = words line
   print $ solution firstWord secondWord

