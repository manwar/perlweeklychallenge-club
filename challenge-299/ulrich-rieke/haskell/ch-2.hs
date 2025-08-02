module Challenge299_2
   where
import Control.Applicative
import Data.List ( (!!) , transpose)
import qualified Data.Set as S
import Data.List.Split ( divvy ) 
import Data.Maybe ( fromJust )
import Data.Char ( isSpace )   

isNeighbouring :: (Int, Int) -> (Int , Int) -> Bool
isNeighbouring (r1 , c1 ) (r2 , c2 ) = ( r1 == r2 && ( abs( c1 - c2 ) == 1 )) 
 || (abs( r1 -r2) == 1 && c1 == c2 )   

findPositions :: [String] -> Char ->[[(Int , Int)]]
findPositions input letter =
   let inputlen = length input
       rowlen = length $ head input
   in [[(r , c)] | r <- [0..inputlen - 1] , c <- [0..rowlen - 1] , input !! r
    !! c == letter ]

enterLines :: IO [String]
enterLines = do
   line <- getLine
   if null line then return []
   else (line : ) <$> enterLines 

letterPositions :: [String] -> [(Char , [[(Int , Int)]])]
letterPositions input =
   let longstring = foldl1 (++) input
       allLetters = S.toList $ S.fromList longstring
   in map (\c -> (c , findPositions input c )) allLetters

isValid :: [(Int , Int)] -> Bool
isValid list 
   |length list == 1 = True
   |otherwise = condition1 && condition2
    where
     condition1 = (S.size $ S.fromList list) == length list
     condition2 = all (\li -> isNeighbouring ( head li ) ( last li ) )
      $ divvy 2 1 list
      

combine :: [[(Int , Int)]] -> [[(Int , Int)]] -> [[(Int , Int)]]
combine firstCombis secondCombis = filter isValid ( (++) <$> firstCombis
 <*> secondCombis)

solution :: [String] -> String -> Bool
solution input word 
   |any ( == word ) input = True
   |any ( == (reverse word )) input = True
   |any ( == word ) transposed = True
   |any ( == (reverse word ) ) transposed = True
   |length word > (length input * ( length $ head input )) = False
   |otherwise = any (\v -> length v == length word ) $ foldl1 combine 
    allLetterPositions
    where
     transposed = transpose input
     lettermap = letterPositions input
     allLetterPositions = map (\d -> fromJust $ lookup d lettermap ) word

main :: IO ( ) 
main = do
   putStrLn "Enter some letters separated by blanks!"
   putStrLn "Enter <return> to end!" 
   input <- enterLines
   putStrLn "Enter a word!" 
   word <- getLine
   let relevantLines = map (\l -> filter ( not . isSpace ) l ) input 
   print $ solution relevantLines word
