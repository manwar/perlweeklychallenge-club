module Challenge171_2
  where

func1 :: Int -> Int
func1 = ( * 5 )

func2 :: Int -> Double
func2 = sqrt . fromIntegral

compose :: Int -> Double
compose = func2 . func1
