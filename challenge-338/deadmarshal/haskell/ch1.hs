module Ch1 where

highestRow :: Integral a => [[a]] -> a
highestRow xs = maximum $ map sum xs

main :: IO ()
main = do
  print $ highestRow [[4,4,4,4],[10,0,0,0],[2,2,2,9]]
  print $ highestRow [[1,5],[7,3],[3,5]]
  print $ highestRow [[1,2,3],[3,2,1]]
  print $ highestRow [[2,8,7],[7,1,3],[1,9,5]]
  print $ highestRow [[10,20,30],[5,5,5],[0,100,0],[25,25,25]]

