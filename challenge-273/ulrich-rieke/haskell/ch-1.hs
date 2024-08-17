module Challenge273
   where
import Data.List ( findIndices ) 

solution :: String -> Char -> Int
solution haystack needle =
   let percentage = ((fromIntegral $ length $ findIndices ( == needle ) haystack) /
        (fromIntegral $ length haystack)) * 100.0
       bottom = floor percentage
   in if percentage - ( fromIntegral bottom ) > 0.4 then bottom + 1 else bottom

main :: IO ( )
main = do
   putStrLn "Enter a word!" 
   word <- getLine
   putStrLn "Enter a character!" 
   character <- getLine
   print $ solution word ( head character )
