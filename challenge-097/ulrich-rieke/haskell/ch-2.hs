module Challenge097_2
  where
import Data.List ( transpose )
import qualified Data.Text as T

solution :: String -> Int -> Int
solution binarystring blocks =
  let strlen = length binarystring
      chunknumber = div strlen blocks
      chunksize = div strlen chunknumber
      chunks = map T.unpack $ T.chunksOf chunksize $ T.pack binarystring
      myWords = transpose chunks
      toBeFlipped = map findFlips myWords
  in sum toBeFlipped

count :: Char -> String -> Int
count c str = length $ filter ( c == ) str

findFlips :: String -> Int
findFlips  str
  |zeroes >= ones = length str - zeroes
  |otherwise = length str - ones
  where
      zeroes :: Int
      zeroes = count '0' str
      ones :: Int
      ones = count '1' str
