module Challenge264
   where
import Data.Char ( isUpper , toLower)
import Data.List ( sort )

solution :: String -> Char
solution str = if not $ null selected then last $ sort selected else ' '
 where
  selected :: [Char]
  selected = filter (\c -> isUpper c && ( elem ( toLower c ) str )) str

main :: IO ( )
main = do
   putStrLn "Enter a string!" 
   line <- getLine
   print $ solution line 
