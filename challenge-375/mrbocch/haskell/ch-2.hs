import Data.Function

kBeauty :: Int -> Int -> Int
kBeauty num k = windows k (show num)
              & map (read :: String -> Int)
              & filter ((==0) . mod num)
              & length

  where
    windows :: Int -> [a] -> [[a]]
    windows k nums@(_:rest)
      | length nums == k = [take k nums]
      | otherwise        = take k nums : windows k rest

main :: IO ()
main = do
  print $ kBeauty 240 2  == 2
  print $ kBeauty 1020 2 == 3
  print $ kBeauty 444 2  == 0
  print $ kBeauty 17 2   == 1
  print $ kBeauty 123 1  == 2
