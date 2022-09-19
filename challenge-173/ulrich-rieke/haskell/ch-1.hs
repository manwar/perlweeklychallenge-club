module Challenge173
  where
import Data.Char ( digitToInt )

isEsthetic :: Int -> Bool
isEsthetic n = all ( == 1 ) $ map (\p -> abs ( fst p - snd p ) ) $ zip digits
( tail digits )
where
  digits :: [Int]
  digits = map digitToInt $ show n

main :: IO ( )
main = do
  putStrLn "Enter an integer!" ;
  number <- getLine
  if ( isEsthetic $ read number )
  then putStrLn ( number ++ " is esthetic!" )
  else putStrLn ( number ++ " is not esthetic!" )
