module Challenge363_2
   where
import Data.List.Split ( splitOn )
import Data.Char ( isDigit )

isValidAddress :: String -> Bool
isValidAddress ipv4 = and [ length parts == 4 , all ( all isDigit ) parts , 
 all (\n -> n >= 0 && n <= 255 ) numbers]
  where
   parts :: [String]
   parts = splitOn "." ipv4
   numbers :: [Int]
   numbers = map read parts

solution :: String -> String -> Bool
solution ipv4 cidr = and [isValidAddress ipv4 , isValidAddress firstPart , 
 all isDigit secondPart , number >= 0 , number <= 32 , take number ( toOctets 
  ipv4 ) == take number ( toOctets firstPart )]
   where
    firstPart :: String
    firstPart = head $ splitOn "/" cidr
    secondPart :: String
    secondPart = last $ splitOn "/" cidr
    number :: Int
    number = read secondPart 

toBinaryString :: Int -> String
toBinaryString number = snd $ until ((== 0) . fst ) step ( number , [] )
  where
   step :: ( Int , [Char] ) -> ( Int , [Char] )
   step ( startnumber , startstring ) = ( div startnumber 2 , if mod startnumber 2 == 
     1 then '1' : startstring else '0' : startstring )    

toOctets :: String -> String
toOctets numberstring = 
   let numbers = ( map read $ splitOn "." numberstring :: [Int])
       binarystrings = map toBinaryString numbers
   in foldl1( ++ ) $ map leftPad binarystrings 

leftPad :: String -> String
leftPad binary = replicate ( 8 - length binary ) '0' ++ binary

main :: IO ( )
main = do
   putStrLn "Enter an IPv4 address!"
   address <- getLine
   putStrLn "Enter a network address in CIDR format!"
   network <- getLine
   print $ solution address network
