module Challenge323_2
   where
import Data.List.Split ( splitOn , divvy)
import Data.List ( init , splitAt) 

parseBracket :: String -> (Int , Int)
parseBracket str = 
   let pair = splitOn "," $ take ( length str - 2 ) $ drop 1 str
   in ( read $ head pair , read $ last pair ) 

makePairs :: String -> [(Int , Int)]
makePairs = map parseBracket . words 

splitSum :: Int -> [Int] -> [Int]
splitSum number list = head $ filter ( (>= number ) . sum ) partialLists
 where
  partialLists :: [[Int]]
  partialLists = map (\i -> fst $ splitAt i list ) [0..length list]

solution :: Int -> [(Int , Int)] -> Double
solution income taxes =
   let uptos = map fst taxes
       differences = if length taxes == 1 then [head uptos] else 
        [head uptos] ++ (map (\subli -> last subli - head subli ) $
         divvy 2 1 uptos) 
       corrected = splitSum income differences 
       taxparts = if sum corrected > income then init corrected ++ [last corrected -
        ( sum corrected - income )] else corrected 
       zipped = zip taxparts ( map snd taxes )
   in sum $ map (\p -> fromIntegral ( fst p ) * ( (fromIntegral $ snd p) / 
	    fromIntegral 100 )) zipped

main :: IO ( )
main = do
   putStrLn "Enter an income!"
   incomeline <- getLine
   putStrLn "Enter tax brackets separated by blanks!"
   putStrLn "Do it like that : [a,b] [c,d] and so on!"
   bracketline <- getLine
   print $ solution ( read incomeline ) (makePairs bracketline ) 
