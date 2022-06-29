main :: IO ()
main = print $ ((\x -> x + 2) . (\x -> x * 2)) 5
