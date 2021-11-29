module Challenge140_2
  where
import Control.Applicative
import Data.List ( sort )

solution :: Int -> Int -> Int -> Int
solution i j k = head $ drop ( k - 1 ) $ sort ( [1 .. j] ++ ((*) <$>
[1 .. j] <*> [2 .. i]))
