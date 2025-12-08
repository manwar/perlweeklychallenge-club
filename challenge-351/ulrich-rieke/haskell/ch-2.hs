module Challenge351_2
   where
import Data.List( sort )
import Data.List.Split ( divvy )

solution :: String -> Bool
solution str = 
   let numbers = map (\i  -> read i :: Double ) $ words str
       neighbours =  divvy 2 1 $ sort numbers
   in all (\subli -> (last subli - head subli) == ( (last $ head neighbours) - 
     (head $ head neighbours) )) neighbours

main :: IO ( )
main = do
   putStrLn "Enter some numbers separated by blanks!"
   numberline <- getLine
   print $ solution numberline
