module Challenge281
   where
import Data.List ( findIndices , ( !! ))
import Data.Char ( digitToInt ) 

createLine :: String -> [String]
createLine base = if base == "light" then take 8 $ cycle ["light" , "dark"]
 else take 8 $ cycle ["dark" , "light"]

solution :: String -> Bool
solution field =
   let baseline = createLine "dark"
       columns = "abcdefgh"
       row = digitToInt $ last field
       col = head field
       colindex = head $ findIndices ( == col ) columns
   in if row == 1 then (baseline !! colindex) == "light" else ( createLine 
    ( baseline !! colindex ) !! ( row - 1 ) ) == "light"	 


main :: IO ( )
main = do
   putStrLn "Enter the coordinates of a chess field!" 
   field <- getLine
   print $ solution field
