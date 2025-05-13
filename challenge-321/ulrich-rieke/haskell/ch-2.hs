module Challenge321_2
   where
import Data.List ( findIndex ) 

reduceStr :: String -> String 
reduceStr str = until ( not . elem '#' ) myReduce str 
   where
    myReduce :: String -> String
    myReduce intermediate = case findIndex ( == '#' ) intermediate of
     Just pos -> take ( pos - 1 ) intermediate ++ drop ( pos + 1 ) 
      intermediate
     Nothing -> intermediate

solution :: [String] -> Bool
solution list = reduceStr (head list) == reduceStr( last list )

main :: IO ( )
main = do
   putStrLn "Enter 2 strings with zero or more #!" 
   stringline <- getLine
   print $ solution $ words stringline
