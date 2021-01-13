module Challenge091
  where
import Data.List ( group )

solution :: String -> String
solution str = foldl1 ( ++ ) $ map (\li -> ( show $ length li ) ++ [head li] )
  $ group str
