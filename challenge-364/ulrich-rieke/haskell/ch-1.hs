module Challenge364
   where
import Data.List ( findIndex , findIndices ) 
import Data.Char ( intToDigit , isAlpha )
import Data.Maybe ( fromJust )   

conversions :: [(String , Char)]
conversions = 
  let lowerletters = zip ( map(\n -> [intToDigit n] ) [1..9] ) "abcdefghi"
      upperletters = zip (map (\n -> show n ++ "#"  ) [10..26] ) "jklmnopqrstuvwxyz"
  in lowerletters ++ upperletters

replaceHash :: String -> String
replaceHash string = until( null . findIndices ( == '#' )) step string
   where
      step :: String -> String
      step aStr = case findIndex ( == '#' ) aStr of
         Just pos -> (take ( pos - 2 ) aStr) ++ [( fromJust $ lookup ( take 3 $ drop 
           ( pos - 2 ) aStr ) conversions )] ++ (drop ( pos + 1 ) aStr)        
         Nothing -> aStr

solution :: String -> String
solution str = 
   let withoutHashes = replaceHash str
   in map (\c -> if isAlpha c then c else fromJust $ lookup [c] conversions ) 
    withoutHashes

main :: IO ( )
main = do
   print $ solution "10#11#12"
   print $ solution "1326#"
   print $ solution "25#24#123"
   print $ solution "20#5"
   print $ solution "1910#26#"
