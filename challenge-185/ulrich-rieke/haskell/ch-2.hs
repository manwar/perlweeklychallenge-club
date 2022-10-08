module Challenge185_2
  where
import Data.Char ( isAlpha, isDigit )
import Data.List.Split ( splitOn )
import Data.List ( findIndices )

step :: String -> String
step [] = []
step (l:ls)
  |not (l == 'x' ) && (isAlpha l || isDigit l) = 'x': ls
  |otherwise              = l : step ls

convert :: String -> String
convert s = until myCondition step s
where
  myCondition :: String -> Bool
  myCondition st = (length $ findIndices (== 'x') st) == 4

main :: IO ( )
main = do
  putStrLn "Enter a number of codes, separated by a blank!"
  inputline <- getLine
  print $ map convert $ splitOn " " inputline
