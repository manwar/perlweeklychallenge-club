module Challenge305_2
   where
import Data.Char ( chr )
import Data.List ( findIndices , sortOn)

translate :: String -> [Char] -> String   
translate word alphabet = map (\i -> chr ( i + 97 )) $ map (\c -> head $
 findIndices ( == c ) alphabet ) word 

solution :: [String] -> [Char] -> [String]
solution words alphabet = 
   let pairs = map (\w -> ( w , translate w alphabet ) ) words
       sorted = sortOn snd pairs
   in map fst sorted

main :: IO ( )
main = do
   putStrLn "Enter some words separated by spaces!" 
   wordline <- getLine
   putStrLn "Enter a complete alphabet , letters separated by spaces!"
   letterline <- getLine
   let letters = map head $ words letterline
   print $ solution ( words wordline ) letters
