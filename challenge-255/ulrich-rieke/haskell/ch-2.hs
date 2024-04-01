module Challenge255_2
   where
import Data.List ( sortOn , dropWhileEnd ) 

getMultipleLines :: Int -> IO [String]
getMultipleLines n
   |n <= 0 = return []
   |otherwise = do
      x <- getLine
      xs <- getMultipleLines ( n - 1 )
      let ret = (x:xs)
      return ret  

count :: Eq a => a -> [a] -> Int
count _ [] = 0 
count d (x:xs)
   |d == x = 1 + count d xs
   |otherwise = count d xs

convert :: String -> String
convert str = dropWhileEnd (\c -> elem c "!,.?()" ) str

solution :: [String] -> String -> String
solution words banned = fst $ last $ sortOn snd $ map (\w -> ( w, count
 w words )) $  filter ( /= banned ) $ map convert words     

main :: IO ( ) 
main = do
   putStrLn "Enter some lines of text!"
   putStrLn "How many lines do you want to enter?"
   lineno <- getLine
   lines <- getMultipleLines ( read lineno )
   putStrLn "Enter a banned word!"
   banned <- getLine
   let allWords = concat $ map ( map convert . words ) lines
   print $ solution allWords banned
