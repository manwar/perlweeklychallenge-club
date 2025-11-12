module Challenge347_2
   where
import Data.List.Split ( splitOneOf , chunksOf )
import Data.List ( init , intercalate )

reduceString :: String -> String
reduceString str = foldl1 ( ++ ) $ splitOneOf "' '-" str 

solution :: String -> String
solution str 
   |rest == 0 = intercalate "-" $ chunksOf 3 reduced
   |rest == 1 = if l == 4 then intercalate "-"  $ chunksOf 2 reduced else 
     if length firstpart == 3 then firstpart ++ "-" ++ ( intercalate "-" $ 
      chunksOf 2 $ drop ( l -4 ) reduced ) else (intercalate "-" $ chunksOf 3
       firstpart ) ++ "-" ++ ( intercalate "-" $ chunksOf 2 $ drop ( l - 4 )
           reduced )
   |rest == 2 = (intercalate "-" $ chunksOf 3 $ take ( l - 2 ) reduced) ++ "-"
     ++ drop ( l - 2 ) reduced
    where
     l :: Int
     l = length reduced
     reduced :: String
     reduced = reduceString str
     firstpart :: String
     firstpart = take ( l - 4 ) reduced 
     rest :: Int
     rest = mod l 3

main :: IO ( )
main = do
   putStrLn "Enter a string consisting of digits, dashes and spaces only!"
   phonenumber <- getLine
   print $ solution phonenumber
