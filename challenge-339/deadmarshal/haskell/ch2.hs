module Ch2 where

peakPoint :: Integral a => [a] -> a
peakPoint = maximum . scanl (+) 0

main :: IO ()
main = do
  print $ peakPoint [-5,1,5,-9,2]
  print $ peakPoint [10,10,10,-25]
  print $ peakPoint [3,-4,2,5,-6,1]
  print $ peakPoint [-1,-2,-3,-4]
  print $ peakPoint [-10,15,5]

