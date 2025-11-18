module Challenge348
   where

solution :: String -> Bool
solution str = (length $ filter ( flip elem vowels ) firsthalf) == (length $ filter
 ( flip elem vowels ) secondhalf )
  where 
   vowels :: [Char]
   vowels = "aAeEiIoOuU"
   l      :: Int
   l      = length str
   firsthalf :: String
   firsthalf = take ( div l 2 ) str
   secondhalf :: String
   secondhalf = drop ( div l 2 ) str

main :: IO ( )
main = do
   print $ solution "textbook"
   print $ solution "book"
   print $ solution "AbCdEfGh"
   print $ solution "rhythmmyth"
   print $ solution "UmpireeAudio"
