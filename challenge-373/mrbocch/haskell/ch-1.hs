import Data.Function

equalList :: [String] -> [String] -> Bool
equalList = on (==) concat

main :: IO ()
main = do
    print $ equalList ["a", "bc"] ["ab", "c"]       == True
    print $ equalList ["a", "b", "c"] ["a", "bc"]   == True
    print $ equalList ["a", "bc"] ["a", "c", "b"]   == False
    print $ equalList ["ab", "c"] ["", "a", "bc"]   == True
    print $ equalList ["p", "e", "r", "l"] ["perl"] == True
