module Challenge265_2
   where
import Data.Char ( isAlpha, toLower )
import qualified Data.Set as S
import Data.Maybe( isJust, fromJust ) 
import Data.List ( sortOn ) 

count :: Eq a => a -> [a] -> Int
count _ [] = 0
count d ( x:xs )
   |d == x = 1 + count d xs
   |otherwise = count d xs

findFrequency :: String -> [(Char , Int)]
findFrequency s = map(\c -> (c , count c s )) $ S.toList $ S.fromList s

convert :: String -> String
convert s = map toLower $ filter isAlpha s

condition :: String -> String -> Bool
condition someString startString = 
   --the following is the frequency of the letters in one of the
   --alphabetic words
   let stringFrequencies = findFrequency someString
   --and this in the alphanumeric word entered at the start   
       wordFrequencies = findFrequency startString
   in all (\(k , i) -> (isJust $ lookup k stringFrequencies) && 
    ( fromJust( lookup k stringFrequencies ) >= i ) ) wordFrequencies

main :: IO ( )
main = do
   putStrLn "Enter an alphanumeric string!" 
   startstring <- getLine
   putStrLn "Enter some alphabetic strings, separated by blanks!" 
   stringline <- getLine
   let strings = words stringline
       converted = convert startstring
       selected = filter (\w -> condition w converted ) strings
   if not $ null selected then print $ head $ sortOn length selected else
    print " " 
