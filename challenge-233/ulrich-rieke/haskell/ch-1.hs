module Challenge233
   where
import qualified Data.Set as S
import Data.List ( group , sort ) 

findPairs :: Int -> Int
findPairs n
   |n == 0 = 0
   |n == 1 = 0
   |n == 2 = 1 
   |n > 2  = myCombis n
   where
    myCombis :: Int -> Int
    myCombis d = div ( product [1..d] ) ( product [1..d - 2] * 2 )

findUniqueLetterCombis :: [String] -> [String]
findUniqueLetterCombis = map ( sort . S.toList . S.fromList )
   
solution :: String -> Int
solution s = sum $ map ( findPairs . length ) $ group $ sort $
 findUniqueLetterCombis ( words s )

main :: IO ( )
main = do
   putStrLn "Enter some words, separated by spaces!" 
   allWords <- getLine
   print $ solution allWords
