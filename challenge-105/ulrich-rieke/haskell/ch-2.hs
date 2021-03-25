module Challenge105_2
  where
import Data.Char ( toLower )
import Data.List ((!!))

rhymes :: [String]
rhymes = ["bo-b" , "Bonana-fanna fo-f" , "Fee fi mo-m"]

isVowel :: Char -> Bool
isVowel c = elem c "aeiou"

isCritical :: Char -> Bool
isCritical c = elem c "bfm"

solution :: String -> [String]
solution name = [name ++ ", " ++ name ++ ", " ++ (convert (rhymes !! 0 ) ),
convert ( rhymes !! 1 ) , convert ( rhymes !! 2 ) , name ++ "!" ]
where
  start :: Char
  start = head name
  convert :: String -> String
  convert s
      |isVowel $ toLower start =  s ++ [toLower start] ++ tail name
      |isCritical $ toLower start = if (toLower start) == last s
        then init s ++ tail name else s ++ tail name
      |otherwise = s ++ tail name

main :: String -> IO ( )
main name = do
  mapM_ putStrLn $ solution name
