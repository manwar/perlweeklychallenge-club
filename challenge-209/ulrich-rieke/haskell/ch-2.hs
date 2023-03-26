module Challenge209_2
  where
import qualified Data.Set as S
import Data.List( (!!) , (\\) , sort )
import Data.Maybe ( fromJust )

findIntersections :: [[String]] -> [(Int , Int)]
findIntersections entry = [(i , j) | i <- [0..l - 2] , j <-
[i + 1..l - 1] , not $ S.null $ S.intersection ( S.fromList ( tail $ entry !! i ) )
(S.fromList ( tail $ entry !! j ) ) ]
  where
  l = length entry

firstPart :: [[String]] -> [[String]]
firstPart input = map (\i -> if elem i firsts then S.toList (
S.union ( S.fromList ( input !! i ) ) (S.fromList ( input !! ( fromJust $
lookup i pairs )))) else [""] ) [0..length input - 1]
where
  pairs :: [(Int , Int)]
  pairs = findIntersections input
  firsts :: [Int]
  firsts = map fst pairs

secondPart :: [[String]] -> [[String]]
secondPart input = map (\i -> input !! i ) ([0..length input - 1 ] \\ (firsts ++
seconds))
where
  pairs :: [(Int , Int)]
  pairs = findIntersections input
  firsts :: [Int]
  firsts = map fst pairs
  seconds :: [Int]
  seconds = map snd pairs

solution :: [[String]] -> [[String]]
solution input = sort  (filter (\li -> head li /= "") (firstPart input ++
secondPart input ))

askForInput :: [[String]] -> IO [[String]]
askForInput xs = do
  putStrLn "Enter some email addresses, separated by blanks!"
  putStrLn "Enter end to end!"
  line <- getLine
  if ( line == "end" )
  then return xs
  else do
      askForInput (words line:xs)

main :: IO ( )
main = do
  emailAddresses <- askForInput []
  print $ solution emailAddresses
