module Challenge299
   where
import Data.List ( isPrefixOf )

solution :: [String] -> [String] -> String
solution theWords sentencewords = unwords $ map (\s -> if null $ findWord s
 theWords then s else head $ findWord s theWords ) sentencewords      

findWord :: String -> [String] -> [String]
findWord sentenceword theWords = filter (\w -> isPrefixOf w sentenceword )
 theWords

main :: IO ( ) 
main = do
   putStrLn "Enter some words , separated by blanks!"
   firstwords <- getLine
   putStrLn "Enter a sentence!"
   sentence <- getLine
   print $ solution ( words firstwords ) ( words sentence )
