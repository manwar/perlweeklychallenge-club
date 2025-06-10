module Challenge325
   where
import Data.List ( group , sortOn)

solution :: [Int] -> Int   
solution list = 
   let grouped = group list
       selected = filter ( (== 1 ) . head ) grouped
   in if null selected then 0 else length $ last $ sortOn length grouped

main :: IO ( )
main = do 
   putStrLn "Enter some 0 and 1 separated by blanks!"
   binaryline <- getLine
   print $ solution $ map read $ words binaryline
