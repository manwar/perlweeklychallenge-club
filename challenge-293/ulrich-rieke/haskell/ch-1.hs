module Challenge293
   where
import Control.Applicative ;
import Data.List ( (!!) ) 
import qualified Data.Set as S

enterLines :: IO [String]
enterLines = do
   line <- getLine
   if null line then return []
   else (line : ) <$> enterLines

toPair :: String -> (Int , Int)
toPair s = (firstNum , secondNum )
   where
    numbers :: [Int]
    numbers = map read $ words s 
    firstNum :: Int
    firstNum = head numbers 
    secondNum :: Int
    secondNum = last numbers

isSimilar :: (Int , Int) -> (Int , Int) -> Bool
isSimilar ( a , b ) ( c , d ) = ( a == c && b == d ) || ( a == d && b == c ) 

findIndexPairs :: [(Int , Int)] -> [(Int , Int)]
findIndexPairs dominoes = [(i , j)| i <- [0..l - 2] , j <- [i + 1 .. l - 1] , 
 isSimilar ( dominoes !! i ) ( dominoes !! j )]
  where
   l = length dominoes

solution :: [(Int , Int)] -> Int
solution indices = S.size $ S.fromList ( map fst indices ++ map snd indices )

main :: IO ( )
main = do
   putStrLn "Enter 2 integers , separated by blanks, to denote a domino!"
   putStrLn "Enter <return> to end entry!"
   allInput <- enterLines
   print $ solution $ findIndexPairs $ map toPair allInput
