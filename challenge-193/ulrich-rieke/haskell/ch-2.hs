module Challenge193_2
  where
import Data.List.Split( divvy )
import Data.Char ( ord )

developNumArray :: [Int] -> [Int]
developNumArray list = concat $ until ( (== 1 ) . length ) step ( divvy 2 1 list )
where
  step :: [[Int]] -> [[Int]]
  step allSublists = divvy 2 1 $ map (\subli -> last subli - head subli ) allSublists
 
findDifference :: String -> Int
findDifference s = last li - head li
where
  li :: [Int]
  li = developNumArray $ map (\c -> ord c - 97 ) s

separate :: [String] -> [[String]]
separate strings = [firstList , secondList , thirdList]
where
  firstList :: [String]
  firstList = filter (\s -> findDifference s < 0 ) strings
  secondList :: [String]
  secondList = filter( \s -> findDifference s == 0 ) strings
  thirdList = filter (\s -> findDifference s > 0 ) strings

keepAskingForInput :: IO [String]
keepAskingForInput = do
  putStrLn "Enter a line of strings, all of the same length, separated by blanks!"
  input <- getLine
  let theStrings = words input
  if all (\s -> length s == ( length $ head theStrings )) theStrings
    then return theStrings
    else do
    keepAskingForInput

main :: IO ( )
main = do
  allStrings <- keepAskingForInput
  let separatedLists = separate allStrings
  if  all ( (/= 1 ) . length ) separatedLists
  then putStrLn "No distinctive string can be found!"
  else putStrLn $ head $ concat $ filter ((== 1 ) . length )
    separatedLists
