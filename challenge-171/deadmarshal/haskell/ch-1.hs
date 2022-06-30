divisorsSum :: (Integral a) => a -> a
divisorsSum n = sum [x | x <- [1..(div n 2+1)], mod n x == 0]

abundantOddNumbers :: (Integral a) => [a]
abundantOddNumbers =
  [x | x <- [1..], divisorsSum x > x && mod x 2 /= 0]

main :: IO ()
main =
  print $ take 20 abundantOddNumbers
 
