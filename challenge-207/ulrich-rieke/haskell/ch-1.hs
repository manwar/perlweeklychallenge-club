module Challenge207
  where
import Data.Char ( toLower )
import Data.List ( (!!) )

rows :: [String]
rows = ["qwertyuiop" , "asdfghjkl" , "zxcvbnm"]

myCondition :: String -> Bool
myCondition s = all (\c -> elem c ( rows !! 0 ) ) low || all (\c -> elem c ( rows !! 1 ) )
low || all (\c -> elem c ( rows !! 2 ) ) low
where
  low :: String
  low = map toLower s

solution :: [String] -> [String]
solution termlist = filter myCondition termlist
