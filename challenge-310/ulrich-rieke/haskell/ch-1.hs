module Challenge310
   where
import qualified Data.Set as S

enterLines :: IO [String]
enterLines = do
   line <- getLine
   if null line then return []
   else (line : ) <$> enterLines 

solution :: [[Int]] -> [Int]
solution = S.toList . foldl1 ( S.intersection ) . map S.fromList

main :: IO ( ) 
main = do
   putStrLn "Enter some integers separated by blanks!"
   putStrLn "Enter <return> to end!" 
   allLines <- enterLines
   let numberarray = map ( map read . words ) allLines
   print $ solution numberarray 
