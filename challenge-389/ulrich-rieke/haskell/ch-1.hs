module Challenge389
   where
import Data.List ( sortOn , intercalate )
import Data.Char ( toUpper )

solution :: String -> [String] -> [Int] -> String   
solution composer notes permus =
   let zipped = sortOn fst $ zip permus notes
   in (map toUpper composer) ++ " => " ++ (intercalate " " $ map snd zipped)

main :: IO ( )
main = do
   putStrLn "Enter a composer name!"
   composer <- getLine
   putStrLn "Enter some notes!"
   noteline <- getLine
   putStrLn "Enter a many permutations as there are notes!"
   permuline <- getLine
   print $ solution composer ( words noteline ) ( map read $ words permuline )
