module Challenge184
  where

convert :: String -> Int -> String
convert st n
  |n < 10 = "0" ++ show n ++ ( drop 2 st )
  |otherwise = show n ++ ( drop 2 st )

solution :: [String] -> [String]
solution strings = map (\st -> convert ( fst st ) ( snd st )) $ zip strings [0 ..]
