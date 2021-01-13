module Challenge047_2
  where

isGapful :: Int -> Bool
isGapful n =
  let numberstring = show n
      firstDigit = head numberstring
      lastDigit = last numberstring
  in  mod n ( read  ( [firstDigit] ++ [lastDigit] ))  == 0

solution :: [Int]
solution = take 20 $ filter isGapful [100 , 101..]

