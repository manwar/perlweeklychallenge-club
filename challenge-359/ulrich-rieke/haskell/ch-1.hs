module Challenge359
   where
import Data.Char ( digitToInt ) 

solution :: Int -> (Int , Int)
solution number = until ((< 10) . snd ) step( 0 , number )
   where
      step :: (Int , Int) -> (Int , Int)
      step ( somePersistence , someRoot ) = ( somePersistence + 1 , 
       sum $ map digitToInt $ show someRoot )     

main :: IO ( )
main = do
   putStrLn "Please enter a positive integer!"
   numberline <- getLine
   let ( persistence , root ) = solution ( read numberline )
   putStrLn ( "Persistence  = " ++ show persistence )
   putStrLn ( "Digital root = " ++ show root )
