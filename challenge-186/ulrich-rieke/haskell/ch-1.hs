module Challenge186
  where
import Data.List.Split ( splitOn )
import Data.List ( intersperse )

solution :: String -> String -> String
solution s1 s2 = concat $ map (\p -> [fst p , snd p]) $ zip s1 s2

main :: IO ( )
main = do
  putStrLn "Enter a line of digits and characters!" ;
  firstLine <- getLine
  putStrLn "Enter another line of digits and characters!"
  secondLine <- getLine
  print $ intersperse ',' $ solution ( map head $ splitOn " " firstLine )
    ( map head $ splitOn " " secondLine )
