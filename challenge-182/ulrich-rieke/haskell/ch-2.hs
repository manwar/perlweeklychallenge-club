module Challenge182_2
  where
import Data.List ( sortOn )

findSolution :: [String] -> String
findSolution inputLines = head $ last $ filter (\li -> all ( == ( head li )) li )
$ map (\i -> map (\st -> take i st ) inputLines ) [1 .. length shortest]
  where
  shortest :: String
  shortest = head $ sortOn length inputLines

main :: IO ( )
main = do
  inputLines <- fmap lines $ readFile "inputfiles.txt"
  putStrLn $ findSolution inputLines
