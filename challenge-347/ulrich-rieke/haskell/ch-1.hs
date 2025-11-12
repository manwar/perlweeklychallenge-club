module Challenge347
   where
import Data.Char ( isDigit ) 
import Data.List ( findIndices ) 

months :: [String]
months = ["Jan" , "Feb" , "Mar" , "Apr" , "May" , "Jun" , "Jul" , "Aug" , "Sep" , 
       "Oct" , "Nov" , "Dec"]

parseDate :: String -> [String]
parseDate str =
   let [day , month , year] = words str
   in [takeWhile isDigit day , month , year]

convert :: String -> String
convert str = if length str == 1 then "0" ++ str else str

solution :: String -> String
solution str =
   let [day , month , year] = parseDate str
   in year ++ "-" ++ (convert $ show ( (head $ findIndices (== month ) months ) + 1)) ++ 
    "-" ++ convert day

main :: IO ( ) 
main = do
   print $ fmap solution ["1st Jan 2025" , "22nd Feb 2025" , "15th Apr 2025" , 
    "23rd Oct 2025" , "31st Dec 2025"]
