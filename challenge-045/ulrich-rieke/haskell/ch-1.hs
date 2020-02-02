module Challenge045
  where
import Data.List ( transpose , intercalate )
import Data.List.Split ( chunksOf )

solution :: String -> String
solution toBeEncoded =
  let withoutSpaces = foldl1 (++) $ words toBeEncoded
      columnstarter = chunksOf 8 withoutSpaces
      downTheColumns = transpose columnstarter
  in intercalate " " downTheColumns
