module Challenge173_2
  where

step :: [Integer] -> [Integer]
step list = list ++ [ product list + 1]

solution :: [Integer]
solution = until ( (== 10 ) . length ) step [ 2 , 3 ]

main :: IO ( )
main = do
  let numbers = map show solution
  mapM_ putStrLn numbers
