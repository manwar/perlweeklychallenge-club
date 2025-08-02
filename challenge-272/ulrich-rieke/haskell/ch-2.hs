module Challenge272_2
   where
import Data.Char ( ord )
import Data.List.Split ( divvy )

solution :: String -> Int
solution = sum . map (\li -> abs ( (ord $ head li) - (ord $ last li))) .
 divvy 2 1 
