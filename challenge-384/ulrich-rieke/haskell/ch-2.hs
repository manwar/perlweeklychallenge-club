module Challenge384_2
   where
import Data.List ( find ) 

condition :: String -> Bool
condition str =
   let half = div ( length str ) 2
       first = replicate half '0'
       second = replicate half '1'
       (firsthalf , secondhalf) = splitAt half str
   in ( firsthalf == first && secondhalf == second ) || ( firsthalf == 
         second && secondhalf == first )

--find appropriate substring in dependence of a given start position
findString :: String -> Int -> String
findString str startpos =
   let substrings = [take l $ drop startpos str | l <- [2..length str - 
        startpos] , even l]
   in case find condition substrings of
      Just s -> s
      Nothing -> ""

solution :: String -> [String]
solution binary = filter ( not . null ) [findString binary n | n <-
 [0..length binary - 2]]

main :: IO ( )
main = do 
   putStrLn "Enter a binary consisting of 0 and 1 only!"
   binary <- getLine
   print $ solution binary
