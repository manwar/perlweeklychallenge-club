module Challenge380_2
   where
import Data.Char ( ord )

solution :: String -> Int   
solution string = sum $ map (\p -> fst p * ( 123 - ( ord $ snd p )))
   $ zip [1 , 2 ..] string

main :: IO ( )
main = do
   putStrLn "Enter a string!"
   word <- getLine
   print $ solution word
