module Challenge387
   where
import Data.List.Split ( divvy )

solution :: String -> Int
solution input = fst $ until ( notElem "01". divvy 2 1 . snd ) step (0 ,
 input )
   where
      step :: (Int , String) -> (Int , String )
      step ( currentnumber , currentstring ) = ( currentnumber + 1 ,
            transform currentstring )

transform :: String -> String
transform str = 
   let foundPositions = filter (\i -> (take 2 $ drop i str) == "01" )
        [0..length str - 2]
   in foldl replace str foundPositions

replace :: String -> Int -> String
replace str pos = take pos str ++ "10" ++ drop ( pos + 2 ) str

main :: IO ( )
main = do
   putStrLn "Enter a binary string!"
   binary <- getLine
   print $ solution binary
