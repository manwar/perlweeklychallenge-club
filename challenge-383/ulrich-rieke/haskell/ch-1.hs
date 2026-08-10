module Challenge383
   where
import qualified Data.Map.Strict as M
import Data.List ( tail )
import Data.Maybe ( fromJust , isJust) 

getLines :: IO [String]
getLines = do
   line <- getLine
   if null line then return []
   else (line : ) <$> getLines

createMap :: [String] -> M.Map String [String]
createMap input = 
   let wordlines = map words input
       lineMaps = map (\l -> M.fromList [(head l , tail l)] ) wordlines
   in foldl1 ( M.union ) lineMaps    

solution :: [String] -> [String] -> M.Map String [String] -> Bool
solution firstLine secondLine similarities =
   let zipped = zip firstLine secondLine
       notEqual = filter (\p -> fst p /= snd p ) zipped
   in if length firstLine /= ( length secondLine ) then False else (all (\p -> (isJust $ 
     M.lookup ( fst p ) similarities) && ( elem ( snd p ) $ fromJust $ M.lookup ( fst p ) 
      similarities )) notEqual)

main :: IO ( ) 
main = do
   putStrLn "Enter a first list of words separated by blanks!"
   firstLine <- getLine
   putStrLn "Enter a second list of word separated by blanks!"
   secondLine <- getLine
   putStrLn "Enter a word map by entering words , <newline> to end entry!"
   mapLines <- getLines
   let similarities = createMap mapLines
       firstWords = words firstLine
       secondWords = words secondLine
   print $ ( solution firstWords secondWords similarities || ( solution secondWords firstWords 
            similarities ))

