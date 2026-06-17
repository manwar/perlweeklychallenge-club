import Data.Char 

-- wester parotia combinator
wParotia :: (c -> e -> f) -> (a -> b -> c) -> (d -> e) -> a -> b -> d -> f
wParotia f g h a b c = f (g a b) (h c)

psi :: (b -> b -> c) -> (a -> b) -> a -> a -> c
psi f g a b = f (g a) (g b)

sumOfWords :: String -> String -> String -> Bool 
sumOfWords = wParotia (==) (psi (+) ofWord) ofWord   

ofWord :: String -> Int 
ofWord = (read :: String -> Int) . concatMap (show . charToBi)
 
charToBi :: Char -> Int 
charToBi =  (+) (-97) . ord 

main :: IO ()
main = do
  print $ sumOfWords "acb" "cba" "cdb"  == True 
  print $ sumOfWords "aab" "aac" "ad"   == True 
  print $ sumOfWords "bc" "je" "jg"     == False 
  print $ sumOfWords "a" "aaaa" "aa"    == True 
  print $ sumOfWords "c" "d" "h"        == False 
  print $ sumOfWords "gfi" "hbf" "bdhd" == True  
