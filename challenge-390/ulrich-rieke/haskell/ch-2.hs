module Challenge390_2
   where
import Data.List ( sort , init , tail )

smallForOne :: String -> String
smallForOne str = head $ sort $ takeWhile (/= str ) $ tail $ iterate moveOne
 str

smallForMoreThanOne :: String -> String
smallForMoreThanOne str = sort str

moveOne :: String -> String
moveOne str = tail str ++ [head str]

main :: IO ( )
main = do
   putStrLn "Enter an alphabetic string and an integer!" 
   line <- getLine
   let [ startword , k ] = words line
   if k == "1" then print $ smallForOne startword else print $
    smallForMoreThanOne startword
