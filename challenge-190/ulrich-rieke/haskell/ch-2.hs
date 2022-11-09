module Challenge190_2
  where
import qualified Data.Set as S
import Data.List ( permutations , sort )
import Data.List.Split ( divvy )
import Data.Char ( chr )

--find all sublists of 1's and 2's that add up to a given integer
findSublists :: Int -> [[Int]]
findSublists l = [replicate t 2  ++ replicate ( l - 2 * t ) 1 |
t <- [ 0 .. div l 2 ]]

findAllPermutations :: [[Int]] -> [[Int]]
findAllPermutations list = (S.toList $ S.fromList $ concat $
map permutations $ filter (\li -> elem 2 li ) list) ++
[head list]

findSubstring :: String -> Int -> Int -> String
findSubstring str from to = take ( to - from ) $ drop from str

findNumberlist :: String -> [Int] -> [Int]
findNumberlist s thePartitions = map read $ map (\li -> findSubstring s
( head li ) ( last li )) $ divvy 2 1 $ scanl ( + ) 0 thePartitions

findWord :: [Int] -> String
findWord list = if any ( > 26 ) list then "" else map ( chr . (+ 64 )) list

solution :: String -> [String]
solution number = sort $ filter ( not . null ) $ map findWord $
map (\li -> findNumberlist number li )
$ findAllPermutations $ findSublists ( length number )

main :: IO ( )
main = do
  putStrLn "Enter a string consisting only of digits!"
  numberstring <- getLine
  print $ solution numberstring
