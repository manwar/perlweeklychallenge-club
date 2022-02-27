main :: IO ()
main = print $ filter isFactorion [1 .. 100000]

isFactorion :: Integer -> Bool
isFactorion 1     = True
isFactorion 2     = True
isFactorion 145   = True
isFactorion 40585 = True
isFactorion _     = False