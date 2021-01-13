module Challenge046_2
  where
import Control.Monad.State.Lazy

starter :: [(Int , String)]
starter = zip [1..500] (take 500 $ repeat "open")

my_flip :: String -> String
my_flip s
  |s == "open" = "closed"
  |otherwise = "open"

changeDoorStatus :: [(Int , String)] -> Int -> [(Int , String)]
changeDoorStatus doornumbers i =
    map (\(n , s ) -> if mod n i == 0 then ( n , my_flip s )
      else ( n , s ) ) doornumbers

findOpenDoors :: Int -> State [(Int ,String)] [Int]
findOpenDoors n = do
  allDoors <- get
  if n == 501
      then return ( map fst $ filter ( ("open" == ) . snd ) allDoors)
  else do
      put $ changeDoorStatus allDoors n
      findOpenDoors ( n + 1 )

main :: IO ( )
main = do
  openDoors <- return $ evalState (findOpenDoors 2 ) starter
  mapM_ putStrLn $ map (\i -> "door " ++ show i ++ " is open!" ) openDoors
