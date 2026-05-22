module Challenge374_2
   where
import Data.List ( group )

solution :: String -> Int
solution = maximum . map read . group

main :: IO ( )
main = do
   putStrLn "Enter a number string consisting of grouped digits only!"
   numberstring <- getLine
   print $ solution numberstring
