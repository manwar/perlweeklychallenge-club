module Challenge220
  where
import qualified Data.Set as S
import Data.Char (toLower)

solution :: [String] -> [Char]
solution = S.toList . foldl1 S.intersection . map ( S.fromList . map toLower )

main :: IO ( )
main = do
  putStrLn "Enter some strings, separated by blanks!"
  line <- getLine
  print $ solution $ words line
