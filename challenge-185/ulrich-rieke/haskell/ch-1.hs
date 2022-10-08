module Challenge185
  where
import Data.List.Split ( splitOn )
import Data.List ( intercalate )

miniconvert :: String -> String
miniconvert quad = take 2 quad ++ ":" ++ drop 2 quad

convert :: String -> String
convert = intercalate ":" . map miniconvert . splitOn "."

main :: IO ( )
main = do
  putStrLn "Enter a MAC address in the form hhhh.hhhh.hhhh!"
  address <- getLine
  putStrLn $ convert address
