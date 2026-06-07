import Data.Char (digitToInt)
import Data.Function (on)

data Color = Black | White
  deriving (Show, Eq)

color :: String -> Color
color ('a':r:[]) = if even $ digitToInt r then White else Black
color ('c':r:[]) = if even $ digitToInt r then White else Black
color ('e':r:[]) = if even $ digitToInt r then White else Black
color ('g':r:[]) = if even $ digitToInt r then White else Black
color (_:r:[])   = if even $ digitToInt r then Black else White
color _ = undefined

sameColor :: String -> String -> Bool
sameColor = on (==) color

main :: IO ()
main = do
  print $ sameColor "a7" "f4" == True
  print $ sameColor "c1" "e8" == False
  print $ sameColor "b5" "h2" == False
  print $ sameColor "f3" "h1" == True
  print $ sameColor "a1" "g8" == False
