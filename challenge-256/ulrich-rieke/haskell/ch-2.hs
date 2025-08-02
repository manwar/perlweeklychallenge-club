module Challenge256_2
   where

solution :: String -> String -> String
solution s1 s2 = (foldl1 ( ++ ) $ map (\p -> [fst p] ++ [snd p] ) common )
 ++ drop ( length common ) longer
 where
  common :: [(Char, Char)]
  common = zip s1 s2
  longer :: String
  longer = if ( length s1 > length s2 ) then s1 else s2
