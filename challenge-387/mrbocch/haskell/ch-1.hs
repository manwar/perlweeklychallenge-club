
generalF :: (a -> Bool) -> (Int -> Int) -> (Int -> Int) -> [a] -> [Int]
generalF p f g xs = gF p f g xs 0
  where
    gF :: (a -> Bool) -> (Int -> Int) -> (Int -> Int) -> [a] -> Int -> [Int]
    gF _ _ _ [] _ = []
    gF p f g (x:xs) c
      | p x       = c : gF p f g xs (f c)
      | otherwise = c : gF p f g xs (g c)

lastDistance :: String -> Int
lastDistance s  
  | elem '1' $ dropWhile (=='1') s = last $ maxD s
  | otherwise                      = 0
  where
    scanlCount :: (a -> Bool) -> [a] -> [Int]
    scanlCount p = generalF p (+1) id

    maxD :: String -> [Int]
    maxD = zipWith (-) [0..]
         . scanlCount (=='1')

lastWait :: String -> Int 
lastWait s
  | elem '1' $ cleared = last $ maxW cleared 
  | otherwise          = 0
  where 
    cleared = dropWhile (=='1') s 
    maxW    = generalF (=='1') (+1) (max 0 . flip (-) 1)

totalSteps :: String -> Int
totalSteps = phoenix (+) lastDistance lastWait  
  where
    phoenix f g h x = f (g x) (h x)

main :: IO ()
main = do
  print $ totalSteps "111000"      == 0
  print $ totalSteps "00011"       == 4 
  print $ totalSteps "01011"       == 3 
  print $ totalSteps "010101"      == 3 
  print $ totalSteps "00001"       == 4 
  print $ totalSteps "10011101"    == 5
  print $ totalSteps "1111111001"  == 2
  print $ totalSteps "01111111001" == 8


