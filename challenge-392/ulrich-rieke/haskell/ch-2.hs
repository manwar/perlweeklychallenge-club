module Challenge392_2
   where
import Data.List ( (!!) )

condition :: String -> String -> Bool
condition first second = all ( flip notElem second ) first

solution :: [String] -> Int
solution list = 
   let allCombis = combis list
       selected = filter (\subli -> condition ( head subli ) ( last subli )) 
             allCombis
   in if null selected then 0 else maximum $ map (\subli -> (length $ head
    subli ) * (length $ last subli ) ) selected
        
combis :: [String] -> [[String]]
combis list = [[list !! i , list !! j] | i <- [0..length list -2] , j <-
 [i + 1 .. length list - 1]]

main :: IO ( )
main = do
   putStrLn "Enter some strings separated by whitespace!"
   line <- getLine
   print $ solution $ words line
