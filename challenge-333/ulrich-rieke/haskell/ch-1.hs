module Challenge333
   where
import Data.Char( isDigit ) 
import Data.List.Split ( chunksOf ) 
import Data.List ( (!!) )

parseEntryLine :: String -> [(Int , Int)]
parseEntryLine line =
   let parts = words line
       numbers = map (filter isDigit  ) parts
       relevant = filter ( not . null ) numbers 
       nums = map read relevant
       coords = chunksOf 2 nums
   in map (\subli -> (head subli , last subli) ) coords

onStraightLine :: [(Int , Int)] -> Bool
onStraightLine coordinates = all (\p -> fst p == ( fst $ head coordinates )) 
 coordinates || all (\p -> snd p == ( snd $ head coordinates )) coordinates ||
 slopeOne == slopeTwo
   where 
      slopeOne :: Double
      slopeOne = (( fromIntegral $ snd ( coordinates !! 1 ) ) - ( fromIntegral $ 
       snd ( coordinates !! 0 ) )) / (( fromIntegral $ fst ( coordinates !! 1 )) - 
        (fromIntegral $ fst ( coordinates !! 0 ) ) )
      slopeTwo = (( fromIntegral $ snd ( coordinates !! 2 ) ) - ( fromIntegral $ 
       snd ( coordinates !! 1 ) )) / (( fromIntegral $ fst ( coordinates !! 2 )) - 
        (fromIntegral $ fst ( coordinates !! 1 ) ) ) 

main :: IO ( ) 
main = do
   putStrLn "Enter some coordinates in brackets separated by comma and space!"
   numberLine <- getLine
   print $ onStraightLine $ parseEntryLine numberLine
   


