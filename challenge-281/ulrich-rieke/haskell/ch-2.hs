module Challenge281_2
   where
import Control.Applicative
import Data.Char ( digitToInt ) 
import Data.Maybe ( fromJust ) 

chessboard :: [(Char , Int)]
chessboard = (,) <$> ['a'..'h'] <*> [1..8]

convert :: String -> (Char , Int)
convert field = ( head field , digitToInt $ last field )

findSuitableTargets :: String -> [(Char , Int)]
findSuitableTargets field = 
   let converted = convert field
       indexedCols = zip ['a'..'h'] [1 , 2 ..]
       fieldCol = fromJust $ lookup ( fst converted ) indexedCols
       fieldRow = snd converted
   in filter (\p -> ((abs ( (fromJust $ lookup ( fst p ) indexedCols) - fieldCol ) == 2 ) 
       && ( abs ( fieldRow - snd p ) == 1 )) || (( abs ( (fromJust $ lookup ( fst p ) 
        indexedCols) - fieldCol ) == 1 ) && ( abs ( fieldRow - snd p ) == 2 ))) chessboard 

solution :: String -> String -> Int
solution from to = fst $ until (\p -> elem target ( snd p )) step (1 , findSuitableTargets
 from )
  where
   target :: (Char , Int)
   target = convert to 
   toString :: (Char , Int) -> String
   toString ( c , num ) = [c] ++ show num 
   step :: (Int , [(Char , Int)]) -> (Int , [(Char , Int)] )
   step ( count , associations ) = ( count + 1 , concat $ map (\p -> findSuitableTargets
    ( toString p ) ) associations )	      
 
main :: IO ( )
main = do
   putStrLn "Enter a source and a target chess field, separated by blanks!" 
   line <- getLine
   let [from , to] = words line
   print $ solution from to 
