module Challenge328_2
   where
import Data.List.Split( divvy )
import Data.List ( findIndex , (!!)) 
import Data.Char ( ord ) 
import Data.Maybe ( isJust , fromJust ) 

condition :: [(Int , Char)] -> Bool
condition sublist = abs ( (ord $ snd $ head sublist) - ( ord $ snd $ last
 sublist )) == 32

changeStr :: String -> String
changeStr str = 
   let zipped = zip [0 , 1 .. ] str
       paired = divvy 2 1 zipped
       result = findIndex condition paired
   in if isJust result then take (fst $ head $ paired !! (fromJust result)) str ++
   ( drop ((fst $ last $ paired !! (fromJust result) ) + 1 ) str ) else str
	 
solution :: String -> String
solution str = fst $ until snd step ( str , False )
   where
    step :: (String , Bool) -> (String , Bool)
    step ( aString , changed ) = ( changeStr aString , changeStr aString == aString) 

main :: IO ( )
main = do
   putStrLn "Enter a word with English letters only!"
   aWord <- getLine
   print $ solution aWord
