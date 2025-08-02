import Data.Char ( chr, ord, digitToInt, isDigit )

mapWithMemory :: (a -> b -> (a, a)) -> a -> [b] -> [a]
mapWithMemory _ _ [] = []
mapWithMemory f init (l:ls) =
  let out_next = f init l
  in [fst out_next] ++ mapWithMemory f (snd out_next) ls

fillHelper :: Char -> Char -> (Char, Char)
fillHelper a b
  | isDigit b = ( (chr $ (ord a) + (digitToInt b) ), a)
  | otherwise = (b, b)
  
fillDigits :: String -> String
fillDigits = mapWithMemory fillHelper ' '

inputs = [
  "a1c1e1",
  "a1b2c3d4",
  "b2b",
  "a16z"
  ]
output = map fillDigits inputs
main = putStrLn $ show output
