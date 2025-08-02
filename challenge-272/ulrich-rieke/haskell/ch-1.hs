module Challenge272
   where
import qualified Data.Text as T

solution :: String -> String
solution s = T.unpack (T.replace (T.pack "." ) (T.pack "[.]") (T.pack s))

main :: IO ( )
main = do
   putStrLn "Enter a valid IPv4 address!" 
   address <- getLine
   putStrLn $ solution address
