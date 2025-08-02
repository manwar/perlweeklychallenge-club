module Challenge332_2
   where
import qualified Data.Set as S

count :: Eq a => a -> [a] -> Int
count _ [] = 0 
count d ( x:xs ) 
   |d == x = 1 + count d xs
   |otherwise = count d xs

solution :: String -> Bool
solution word = all odd $ map (\l -> count l word ) $ S.toList $ S.fromList word

main :: IO ( )
main = do
   putStrLn "Enter a word!"
   word <- getLine
   print $ solution word
