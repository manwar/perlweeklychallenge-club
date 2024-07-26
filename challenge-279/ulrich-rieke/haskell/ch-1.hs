module Challenge279
   where
import Data.Char ( digitToInt ) 
import Data.List ( sortOn ) 

solution :: String -> String -> String
solution letters weights = filter (\c -> c /= ' ' ) $ unwords $ map fst $ sortOn snd $ zip
 ( words letters ) ( map (\w -> digitToInt $ head w ) $ words weights )

main :: IO ( )
main = do
   putStrLn "Enter some letters separated by blanks!" 
   letterline <- getLine
   putStrLn "Enter some weights separated by blanks!"
   weightline <- getLine
   print $ solution letterline weightline
