module Challenge332
   where
import Data.List ( intercalate ) 
import Data.List.Split ( splitOn )   

toBinaryString :: Int -> String
toBinaryString part = reverse $ snd $ until ( (== 0 ). fst ) step ( part ,"" ) 
  where
    step :: (Int , String) -> (Int , String )
    step ( currentNumber, binary ) = ( div currentNumber 2 , binary ++ 
     show ( mod currentNumber 2 ) )

convert :: String -> String  
convert = intercalate "-" . map ( toBinaryString . read ) . splitOn "-"

main :: IO ( )
main = do
   putStrLn "Enter a date in the form year-month-day!" 
   date <- getLine
   print $ convert date
