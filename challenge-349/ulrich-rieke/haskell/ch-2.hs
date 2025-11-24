module Challenge349
   where
import Data.Maybe ( fromJust ) 

data Direction = D|U|R|L deriving ( Eq )

associations :: [(Char , Direction)]
associations = [('U' , U) , ('D' , D) , ('L' , L) , ('R', R)]

move :: (Int , Int) -> Direction -> (Int , Int) 
move point d
   |d == D = (fst point , snd point - 1 )
   |d == U = (fst point , snd point + 1 )
   |d == L = ( fst point - 1 , snd point )
   |d == R = ( fst point + 1 , snd point )

solution :: String -> Bool
solution input =
   let directions = map (\l -> fromJust $ lookup l associations ) input
       target = foldl move (0 , 0) directions
   in fst target == 0 && snd target == 0

main :: IO ( )
main = do
   putStrLn "Enter some letters U , D , R or L denoting motions!"
   motions <- getLine
   print $ solution motions
