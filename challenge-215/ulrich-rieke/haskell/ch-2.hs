module Challenge215_2
  where
import Data.List ( group )

solution :: [Int] -> Int -> Int
solution list zeroesToGo = if any(\li -> length li >= necessary && head li == 0
) $ group list then 1 else 0
where
  necessary :: Int
  necessary = if zeroesToGo == 1 then 3 else 3 + zeroesToGo

condition :: [Int] -> Int -> Bool
condition list toGo = length list > necessary
where
  necessary :: Int
  necessary = if toGo == 1 then 3 else 3 + toGo

main :: IO ( )
main = do
  putStrLn "Enter 1 and 0 , separated by a blank!"
  line <- getLine
  putStrLn "How many 0 should be removed ?"
  toRemove <- getLine
  let numbers = map read $ words line
      kickout = read toRemove
  if condition numbers kickout then print $ solution numbers kickout
  else print 0
