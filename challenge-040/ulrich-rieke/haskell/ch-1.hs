module Challenge040
  where
import Data.List( (!!) , zip3 )

convertLists :: [String] -> [String]
convertLists list = map glue $ zip3 ( list !! 0 ) ( list !! 1 ) ( list !! 2 )
  where
      glue ::(Char, Char , Char) -> String
      glue ( a , b , c ) = [a] ++ [b] ++ [c]
