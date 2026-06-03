module Challenge376
   where
import Data.List ( (!!) , findIndices )
import Data.Char ( digitToInt ) 

chessboard :: [String]
chessboard = reverse $ map (\i -> if odd i then take 8 $ cycle "BW" else take 8 $ 
      cycle "WB" ) [1..8]

solution :: String -> String -> Bool
solution firstpos secondpos = 
   let (firstrow , firstcolumn) = ( (digitToInt $ last firstpos) - 1 , head $ findIndices (
            == head firstpos ) "abcdefgh" )
       (secondrow , secondcolumn )= ( (digitToInt $ last secondpos) - 1 , head $ 
         findIndices ( == head secondpos ) "abcdefgh" )
   in chessboard !! firstrow !! firstcolumn == ( chessboard !! secondrow !! 
         secondcolumn )

main :: IO ( )
main = do
   putStrLn "Enter two chess fields separated by blanks!"
   fieldline <- getLine
   let [ firstfield , secondfield ] = words fieldline
   print $ solution firstfield secondfield
   
