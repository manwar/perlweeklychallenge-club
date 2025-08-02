module Challenge331_2
   where
import Data.List.Split ( divvy )
import qualified Data.Set as S

isSwapped :: [(Char , Char)] -> Bool
isSwapped neighbours = and [fst f == snd s , snd f == fst s]
   where
    f :: (Char , Char)
    f = head neighbours
    s :: (Char , Char)
    s = last neighbours

solution :: [String] -> Bool
solution theWords = and [ S.fromList first == S.fromList second , length first == 
 length second , (length $ filter isSwapped $ divvy 2 1 $ zip first second) 
 == 1 ]  
   where
    first = head theWords
    second = last theWords

main :: IO ( ) 
main = do
   putStrLn "Enter two words separated by space!" 
   line <- getLine
   print $ solution $ words line

