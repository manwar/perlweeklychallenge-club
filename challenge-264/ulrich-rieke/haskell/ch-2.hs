module Challenge264_2
   where
import Control.Monad.State

insertAt :: Int -> Int -> [Int] -> [Int]
insertAt pos newValue list 
   |pos == length list = list ++ [newValue]
   |otherwise = take pos list ++ [newValue] ++ drop  pos list

findList :: [(Int , Int)] -> State [Int] [Int]
findList list = do
   currentList <- get
   if null list then do
      return currentList
   else do
      put $ insertAt ( fst $ head list ) ( snd $ head list ) currentList
      findList ( tail list )
 	    

main :: IO ( ) 
main = do
   putStrLn "Enter some integers, separated by blanks!"
   numberstrings <- getLine
   putStrLn "Enter some indices into this array!"
   indexstrings <- getLine
   let numbers = map read $ words numberstrings
       indices = map read $ words indexstrings
       allPositions = zip indices numbers
   print $ execState ( findList allPositions ) []    
   
