module Challenge267_2
   where
import Data.Maybe ( fromJust )
import Data.List ( maximumBy , (\\) , inits )
import Data.List.Split ( splitOn )
import Data.Function ( on )   

characters :: String
characters = "abcdefghijklmnopqrstuvwxyz"

createWidths :: String -> [(Char , Int)] -> [Int]
createWidths str lettermappings =  map (\c -> fromJust
 $ lookup c lettermappings ) str 

findSublists :: ([Int] -> Bool ) -> [Int] -> [[Int]]
findSublists _ [] = []
findSublists f list = [firstList] ++ findSublists f ( list \\ firstList )  
 where
  firstList :: [Int]
  firstList = maximumBy ( compare `on` length ) $ filter f $ inits list

linesAndPixels :: [Int] -> (Int , Int)
linesAndPixels list = 
   let sublists = findSublists myCondition list   
       len      = length sublists   
       pixels = sum $ last sublists
   in ( len , pixels )

myCondition :: [Int] -> Bool
myCondition someList = if not $ null someList then ( sum someList ) <= 100 
 else True 

main :: IO ( )
main = do
   putStrLn "Enter a string!" 
   string <- getLine
   putStrLn "Enter 26 integers for the character widths, separated by ',' !"
   charwidths <- getLine
   let lettermappings = zip characters ( map read $ splitOn "," charwidths )
       letterplaces = createWidths string lettermappings
   print $ linesAndPixels letterplaces    
