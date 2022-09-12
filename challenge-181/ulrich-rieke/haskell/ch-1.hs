module Challenge181
  where
import Data.List.Split ( splitOn , chunksOf )
import Data.Char ( toUpper )
import Data.List ( findIndices , intercalate , sortBy )

findSentences :: String -> [String]
findSentences str = init $ splitOn "." str

mySorter :: String -> String -> Ordering
mySorter s1 s2
  |small1 < small2 = LT
  |small1 == small2 = EQ
  |small1 > small2 = GT
  where
    small1 :: String
    small1 = map toUpper s1
    small2 :: String
    small2 = map toUpper s2

transformSentences :: String -> [String]
transformSentences str = map (\w -> intercalate " " w ++ ". " )
$ map ( sortBy mySorter ) $ map words $ findSentences str

main :: IO ( )
main = do
  theInput <- readFile "paragraph.txt"
  let transformed = transformSentences theInput
      finalLines = fmap (\str -> foldl1 ( ++ ) $ chunksOf 10 $ words str)
        transformed
      theLines = map unwords $ chunksOf 10 $ words $ foldl1 ( ++ ) transformed
  mapM_ putStrLn theLines
