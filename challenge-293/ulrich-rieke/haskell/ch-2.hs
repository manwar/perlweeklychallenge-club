module Challenge293_2
   where
import Data.List ( (!!) )

enterNLines :: Int -> IO [String]
enterNLines n
   |n <= 0 = return []
   |otherwise = do
      putStrLn "Enter 2 integers as point coordinates , separated by blanks!"
      x <- getLine
      xs <- enterNLines ( n - 1 )
      let ret = (x:xs)
      return ret

toPair :: String -> (Int , Int) 
toPair s = (theFirst , theSecond) 
 where
  numbers :: [Int]
  numbers = map read $ words s 
  theFirst :: Int
  theFirst = head numbers
  theSecond :: Int
  theSecond = last numbers

findSlope :: (Int , Int) -> (Int , Int) -> Double
findSlope p1 p2 = fromIntegral( snd p2 - snd p1) / (fromIntegral( fst p2 - 
	 fst p1 ) )

solution :: [(Int , Int)] -> Bool
solution pairs = and [ length pairs == 3 , pairs !! 0 /= pairs !! 1 , 
 pairs !! 1 /= pairs !! 2 , findSlope ( pairs !! 0 ) ( pairs !! 1 ) /= 
  findSlope ( pairs !! 1 ) ( pairs !! 2 ) ]

main :: IO ( ) 
main = do
   input <- enterNLines 3
   print $ solution $ map toPair input 
