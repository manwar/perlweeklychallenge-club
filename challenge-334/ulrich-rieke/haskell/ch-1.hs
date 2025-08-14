module Challenge334
   where

solution :: [Int] -> [Int] -> Int
solution numbers indices = sum $ take ( to - from + 1 ) $ drop from numbers
   where
      to = last indices
      from = head indices

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks!"
   numberline <- getLine
   putStrLn "Enter 2 valid indices into this array!"
   indexLine <- getLine
   print $ solution ( map read $ words numberline ) ( map read $ words
	 indexLine )
