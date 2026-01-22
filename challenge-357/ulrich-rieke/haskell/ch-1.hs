module Challenge357
   where
import Data.Char ( digitToInt )
import Data.List ( sort )

toNumber :: [Int] -> Int
toNumber list = 
   let multipliers = [10 ^ i | i <- [0..length list - 1]]
   in sum $ zipWith ( * ) multipliers ( reverse list )

step :: Int -> Int
step number = toNumber falling - toNumber rising
   where
      rising :: [Int]
      rising = sort $ map digitToInt corrected 
      falling :: [Int]
      falling = reverse rising
      numberstring :: String
      numberstring = show number 
      l           :: Int
      l            = length numberstring
      corrected  :: String
      corrected = if l < 4 then numberstring ++ replicate ( 4 - l ) '0' else
       numberstring

solution :: Int -> Int
solution number = if all (\c -> c == head numberstring ) numberstring then -1 
 else length $ takeWhile ( /= 6174 ) $ iterate step number 
   where
      numberstring :: String
      numberstring = show number

main :: IO ( )
main = do
   putStrLn "Enter a positive 4-digit number!"
   numberline <- getLine
   print $ solution $ read numberline 
