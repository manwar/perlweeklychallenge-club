module Challenge344_2
   where
import Data.List.Split( divvy )

solution :: [[Int]] -> [Int] -> Bool
solution source target = ((length $ concat source) == length target) && 
 all (\subli -> elem subli ( divvy ( length subli ) 1 target )) source 

getSomeLines :: IO [String]
getSomeLines = do
   line <- getLine
   if null line then return []
   else ( line : ) <$> getSomeLines

main :: IO ( ) 
main = do 
   putStrLn "Enter some integers separated by blanks, <return> to end!"
   allLines <- getSomeLines
   putStrLn "Enter some target numbers!"
   targetNums <- getLine
   let source = map ( map read . words ) allLines
       target = map read $ words targetNums
   print $ solution source target    
