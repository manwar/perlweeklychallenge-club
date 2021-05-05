module Challenge111_2
  where
import Data.List ( sort , sortOn )

selectWord :: [String] -> String
selectWord wordlist = snd $ last $ sortOn fst $ map tupleUp $
filter (\word -> word == sort word) wordlist


tupleUp :: String -> ( Int, String)
tupleUp str = ( length str , str )

main:: IO( )
main = do
  allWords <- fmap lines $ readFile "unixdict.txt"
  putStrLn $ selectWord allWords
