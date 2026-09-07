module Challenge386
   where
import Data.Maybe ( fromJust )
import Data.Char ( chr ) 

conversionTable :: [(Int , Char)]
conversionTable =
   let firstPart = [(n , chr( n + 48 )) | n <- [0..9]]
       secondPart = [(n , chr( n + 55 )) | n <- [10..36]]
       thirdPart = [(n , chr( n + 61 )) | n <- [37..63]]
   in firstPart ++ secondPart ++ thirdPart ++ [(64 , '+')] ++ [(65 , '/')]

findTable :: [(Char , Int)]
findTable = map (\p -> (snd p , fst p )) conversionTable

convert :: String -> Int -> Int
convert numberstring base =
   let converted = map (\c -> fromJust $ lookup c findTable ) $ reverse
        numberstring
       partners = take ( length converted ) $ iterate ( * base ) 1 
   in sum $ zipWith ( * ) partners converted

main :: IO ( )
main = do
   putStrLn "Enter a number string in a given base!" 
   numberstring <- getLine
   putStrLn "Enter a base!"
   base <- getLine
   print $ convert numberstring ( read base :: Int )
