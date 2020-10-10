module Challenge081
  where
import qualified Data.Set as S
import Data.Semigroup ( stimes )

divisors :: Int -> [Int]
divisors n = [ d | d <- [1,2..n] , mod n d == 0 ]

findSequences :: String -> [String]
findSequences str = map (\i -> take i str) $ divisors l
  where
      l :: Int
      l = length str

findBaseStrings :: String -> [String]
findBaseStrings str = filter (\s -> stimes ( div l ( length s )) s == str )
$ findSequences str
where
  l :: Int
  l = length str

solution :: String -> String -> [String]
solution stringA stringB = S.toList ( (S.fromList $ findBaseStrings stringA)
`S.intersection` (S.fromList $ findBaseStrings stringB) )
