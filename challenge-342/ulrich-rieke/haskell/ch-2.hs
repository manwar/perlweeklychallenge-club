module Challenge342_2
   where
import Data.List( splitAt , findIndices )

countChars :: String -> Char -> Int
countChars str c = length $ findIndices( == c ) str

solution :: String -> Int
solution str = 
   let l = length str
       splitPairs = [splitAt n str | n <- [1..l - 1]]
       zerocounts = map ( (flip countChars '0' ) . fst ) splitPairs
       onecounts = map ( (flip countChars '1' ) . snd ) splitPairs
   in maximum $ zipWith ( + ) zerocounts onecounts

main :: IO ( )
main = do
   putStrLn "Enter a string consisting of 0 and 1 only!"
   word <- getLine
   print $ solution word
