module Challenge334_2
   where
import Data.List.Split ( chunksOf )
import Data.Char ( isDigit ) 
import Data.List ( sortOn ) 

parseEntryLine :: String -> [(Int , Int)]
parseEntryLine line =
   let parts = words line
       numbers = map (filter isDigit  ) parts
       relevant = filter ( not . null ) numbers 
       nums = map read relevant
       coords = chunksOf 2 nums
   in map (\subli -> (head subli , last subli) ) coords

isValid :: (Int , Int) -> (Int , Int ) -> Bool
isValid comparison point = or[ fst comparison == fst point , 
 snd comparison == snd point ]

manhattan :: (Int , Int) -> (Int , Int ) -> Int
manhattan firstPoint secondPoint = abs( fst firstPoint - fst secondPoint )
 + abs( snd firstPoint - snd secondPoint )

solution :: [(Int ,(Int , Int))] -> (Int , Int) -> Int
solution allPoints origin 
   |null valids = -1 
   |length valids == 1 = fst $ head valids
   |otherwise = fst $ head sorted
    where
     valids :: [(Int , (Int , Int))]
     valids = filter (\p -> isValid origin ( snd p ) ) allPoints
     sorted :: [(Int , (Int , Int))]
     sorted = sortOn (\p -> manhattan ( snd p ) origin ) valids

main :: IO ( ) 
main = do
   putStrLn "Enter two integers separated by blanks!" 
   originline <- getLine
   putStrLn "Enter some points ( in brackets ) , separated by blanks!"
   pointLine <- getLine
   let numbers = map read $ words originline
       coordinates = parseEntryLine pointLine
       zipped = zip [0 , 1 ..] coordinates
       origin = (head numbers , last numbers )
   print $ solution zipped origin
