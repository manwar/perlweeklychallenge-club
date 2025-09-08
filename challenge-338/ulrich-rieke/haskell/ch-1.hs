module Challenge338
   where

getSomeLines :: IO [String] 
getSomeLines = do
   line <- getLine
   if null line then return []
   else (line : ) <$> getSomeLines

findMaxRow :: [[Int]] -> Int
findMaxRow = maximum . map sum 

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks, <return> to end!"
   allLines <- getSomeLines
   let matrix = map ( (map read) . words ) allLines
   print $ findMaxRow matrix

   
