module Challenge151
  where

count :: Eq a => a -> [a] -> Int
count element list = length $ filter ( (== element) ) list

main :: IO ( )
main = do
  putStrLn "Please enter a tree, levels separated by |!" ;
  tree <- getLine ;
  putStrLn $ show $ count '|' tree
