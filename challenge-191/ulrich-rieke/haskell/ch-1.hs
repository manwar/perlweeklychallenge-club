module Challenge191
  where
import Data.List ( delete )

solution :: [Int] -> Int
solution list = if all (\i -> max >= 2 * i ) theRest then 1 else -1
where
  max :: Int
  max = maximum list
  theRest :: [Int]
  theRest = delete max list

main :: IO ( )
main = do
  putStrLn "Please enter a numbers of integers separated by blanks!" ;
  allNumbers <- getLine
  print $ solution $ map read $ words allNumbers
