module Challenge379_2
   where
import Data.List ( any )

toBaseDigits :: Int -> Int -> [Int]
toBaseDigits base number = snd $ until ( (== 0 ) . fst ) step ( number , [] )
   where
      step :: (Int , [Int] ) -> (Int , [Int] )
      step ( currentNumber , currentList ) = ( div currentNumber base , 
            (mod currentNumber base):currentList )

isArmstrong :: Int -> Int -> Bool 
isArmstrong base number = 
   let basedigits = toBaseDigits base number
       l          = length basedigits
   in (not $ any ( > 9 ) basedigits) && (( sum $ map ( ^ l ) basedigits ) ==
    number )

main :: IO ( )
main = do
   putStrLn "Enter , separated by blanks , a base and a number!"
   line <- getLine
   let parts = words line
       base = ( read $ head parts :: Int )
       limit = ( read $ last parts :: Int )
   print ( [0..base - 1] ++ filter (\n -> isArmstrong base n ) [base..limit -
         1] )
