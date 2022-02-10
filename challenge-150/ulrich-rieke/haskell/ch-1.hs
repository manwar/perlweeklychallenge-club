module Challenge150
  where

--no lengthy input validation, I assume the 2 strings to be of the right shape
solution :: String -> String -> Char
solution firstNum secondNum = head $ drop 50 $ snd $ until( (>= 51 ) . length . snd )
(\p -> (snd p ,  fst p ++ snd p )) ( firstNum, secondNum )
