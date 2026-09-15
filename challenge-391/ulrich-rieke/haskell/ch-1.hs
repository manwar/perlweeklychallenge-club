module Challenge391
   where
import Data.List ( sort , (!!) )

solution :: [Int] -> [Int] -> Double
solution firstarray secondarray =
   let commonarray = firstarray ++ secondarray
       l           = length commonarray
   in if odd l then fromIntegral $ commonarray !! ( div l 2 ) else 
    fromIntegral ( commonarray !! ( div l 2 ) + commonarray !! 
          (div l 2 + 1) ) / 2.0

main :: IO ( )
main = do
   putStrLn "Enter an array of sorted integers!" 
   firstline <- getLine
   putStrLn "Enter a second array of sorted integers!"
   secondline <- getLine
   print $ solution ( map read $ words firstline ) ( map read $ words 
         secondline ) 
