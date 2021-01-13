module Challenge092
  where
import Data.List ( sortOn, groupBy )

isIsomorphic :: String -> String -> Bool
isIsomorphic str1 str2
  |length str1 /= length str2 = False
  |otherwise = ( groupBy (\p1 p2 -> snd p1 == snd p2) orderedPairs) ==
    ( groupBy (\p1 p2 -> fst p1 == fst p2 ) orderedPairs)
    where
      orderedPairs :: [(Char , Char)]
      orderedPairs = sortOn fst $ zip str1 str2
