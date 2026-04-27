module Challenge370_2
   where
import Data.List ( sort ) 

areAnagrams :: String -> String -> Bool
areAnagrams first second = sort first == sort second

areScrambled :: String -> String -> Bool
areScrambled wordA wordB =
   let allSplits = map (\i -> ( splitAt i wordA , splitAt i wordB )) [1..length
        wordA - 2]
   in any (\pair -> ((areAnagrams ( fst $ fst pair ) ( fst $ snd pair )) && 
         (areAnagrams ( snd $ fst pair ) ( snd $ snd pair ))) || ((areAnagrams
            (snd $ fst pair ) ( fst $ snd pair )) && (areAnagrams ( fst $ fst pair )
             ( snd $ snd pair )))) allSplits

main :: IO ( )
main = do
   putStrLn "Enter two strings with equal length!"
   line <- getLine
   let theWords = words line
   print $ areScrambled ( head theWords ) ( last theWords )
