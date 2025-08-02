module Challenge312_2
   where
import Data.List.Split ( chunksOf )
import Data.List ( sortOn , groupBy )

solution :: String -> Int
solution boxstring =
   let
     pairs = map (\subli -> ( last subli , head subli ) ) $ chunksOf 2 boxstring
     ordered = sortOn fst pairs
     grouped = groupBy (\p1 p2 -> fst p1 == fst p2 ) ordered
     joined = map (\subli -> ( fst $ head subli , map snd subli )) grouped
   in length $ filter ( (== 3 ) . length . snd ) joined

main :: IO ( ) 
main = do
   putStrLn "Enter a string consisting of letters R , G , B and numbers 0-9!"
   myString <- getLine
   print $ solution myString

