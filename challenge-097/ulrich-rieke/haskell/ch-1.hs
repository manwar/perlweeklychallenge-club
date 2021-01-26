module Challenge097
  where
import Data.Maybe( fromJust )

caesarencode :: String -> Int -> String
caesarencode plain leftshift = map (\c -> if c /= ' ' then fromJust $ lookup c
mappedPairs else ' ') plain
where
  alfabet :: [Char]
  alfabet = ['A' .. 'Z']
  realshift :: Int
  realshift = mod leftshift ( length alfabet )
  leftRotated :: [Char]
  leftRotated = (take realshift $ reverse alfabet) ++ take ( length alfabet -
    realshift ) alfabet
  mappedPairs :: [(Char , Char)]
  mappedPairs = zip alfabet leftRotated
