module Challenge308_2
   where
import Data.Bits ( xor )

--we take advantage of the fact that xor is its own inverse function
solution :: [Int] -> Int -> [Int]
solution encoded initial = scanl1 xor newList
   where
    newList = initial : encoded

main :: IO ( ) 
main = do
   putStrLn "Enter some integers separated by whitespace!"
   numberline <- getLine
   putStrLn "Enter an initial value!"
   value <- getLine
   print $ solution ( map read $ words numberline ) ( read value ) 

