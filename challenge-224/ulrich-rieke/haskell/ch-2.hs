module Challenge224_2
  where
import Data.Char ( isDigit , digitToInt )
import Data.List ( nub , (!!) )
import Data.List.Split ( splitPlaces )
import qualified Data.Set as S

partitions :: Int -> [[Int]]
partitions n = S.toList $ S.fromList (filter ( (== n) . sum ) $ concat $ map (\i ->
combinations i totallist ) [1..n])

where
  totallist :: [Int]
  totallist = concat $ map(\i -> replicate ( div n i ) i ) [1..n]

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] ,
x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]

extractArray :: String -> [Int] -> [Int]
extractArray numberstr intpart = map read $ splitPlaces intpart numberstr

isAdditive :: [Int] -> Bool
isAdditive list = l > 2 && all (\i -> (list !! (i - 2 )) +
(list !! ( i - 1 )) ==  list !! i ) [2..l - 1]
where
  l :: Int
  l = length list

solution :: String -> Bool
solution s = any isAdditive $ map (\sublist -> extractArray s sublist )
$ partitions ( length s )

askForCorrectInput :: IO String
askForCorrectInput = do
  putStrLn "Please enter a string consisting of digits only!"
  numberstring <- getLine
  if all isDigit numberstring
  then return numberstring
  else do
      askForCorrectInput

main :: IO ( )
main = do
  numberstring <- askForCorrectInput
  if solution numberstring then print "true" else print "false"
