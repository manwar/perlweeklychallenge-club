module Challenge110_2
  where
import Data.List ( transpose )
import Data.List.Split ( splitOn )

main :: IO ( )
main = do
  lines <- fmap lines $ readFile "input"
  let splitLines = map (\li -> splitOn "," li) lines
      transposed = transpose splitLines
      transposedLines = fmap (\line -> foldl1 (++ ) $ map ( ++ "," ) line )
        transposed
  mapM_ putStrLn $ fmap init transposedLines--init to get away with the final comma
