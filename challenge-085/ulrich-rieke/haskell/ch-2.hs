module Challenge085_2
  where
import Control.Applicative

solution :: Integer -> Integer
solution n = if elem n powerlist then 1 else 0
  where
      lowerlimit :: Integer
      lowerlimit = toInteger $ floor $ sqrt $ fromIntegral n
      upperlimit :: Integer
      upperlimit = lowerlimit + 1
      powerlist :: [Integer]
      powerlist = (^) <$> [2..lowerlimit] <*> [2..upperlimit]
