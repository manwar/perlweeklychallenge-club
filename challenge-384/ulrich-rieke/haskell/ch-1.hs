module Challenge384
   where
import Data.Char ( chr ) 
import Data.Maybe ( fromJust ) 

conversionTable :: [(Int , Char)]
conversionTable =
   let firstPart = [(n , chr( n + 48 )) | n <- [0..9]]
       secondPart = [(n , chr( n + 55 )) | n <- [10..36]]
       thirdPart = [(n , chr( n + 61 )) | n <- [37..63]]
   in firstPart ++ secondPart ++ thirdPart ++ [(64 , '+')] ++ [(65 , '/')]

convert :: Int -> Int -> String
convert number base =  snd $ until ( (== 0 ) . fst ) step (number , [] )
 where
   step :: (Int , String) -> (Int , String)
   step (currentnumber , currentstring ) = ( div currentnumber base , ( (fromJust
     $ lookup ( mod currentnumber base ) conversionTable ) : currentstring))   

main :: IO ( )
main = do
   putStrLn "Enter a number and a base!"
   line <- getLine
   let parts = words line
   print $ convert ( read $ head parts ) ( read $ last parts )
