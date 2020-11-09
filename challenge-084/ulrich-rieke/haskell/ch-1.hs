module Challenge084
  where

solution :: Integer -> Integer
solution number
  |number < 0 = (read $ reverse $ show $ abs number) * (-1)
  |number > 0 && number <= 2147483647 = read $ reverse $ show number
  |otherwise = 0
