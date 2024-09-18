module Challenge286
   where
import System.Random
import Data.List ( (!!) ) 

pickWord :: [String] -> String
pickWord words = words !! pos
   where
    gen = mkStdGen 137
    pos = fst $ uniformR ( 0 :: Int , length words - 1 :: Int ) gen

main :: IO ( ) 
main = do
   allLines <- readFile "Challenge286.hs" 
   let allTheWords = words allLines
       relevantWords = filter ( not . null ) allTheWords
   print $ pickWord relevantWords  
