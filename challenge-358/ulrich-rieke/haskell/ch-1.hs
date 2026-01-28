module Challenge358
   where
import Data.Char ( isDigit ) 

convert :: String -> Int
convert str = if condition str then ( read str :: Int ) else length str
   where
      condition :: String -> Bool
      condition someStr = all isDigit someStr

main :: IO ( )
main = do
   putStrLn "Enter some alphanumeric strings separated by blanks!"
   termline <- getLine
   print $ maximum $ map convert $ words termline
