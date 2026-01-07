module Challenge355
   where
import Data.List.Split ( chunksOf )
import Data.List ( intercalate )

chopInThree :: String -> String
chopInThree s = intercalate "," $ chunksOf 3 s

solution :: Int -> String 
solution number =
   let numberstring = show number
       l            = length numberstring
       leading      = mod l 3
   in if l < 3 then numberstring else if leading /= 0 then (take leading numberstring)
    ++ "," ++ (chopInThree $ drop leading numberstring) else chopInThree 
     numberstring

main :: IO ( ) 
main = do
   print $ map solution [123 , 1234 , 1000000 , 1 , 12345]
   
   
