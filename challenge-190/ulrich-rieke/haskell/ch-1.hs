module Challenge190
  where
import Data.Char ( isUpper , isLower )

solution :: String -> Int
solution input = if (all isUpper input || all isLower input || ( isUpper
( head input ) && all isLower (tail input) )) then 1 else 0
