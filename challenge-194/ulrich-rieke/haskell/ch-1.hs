module Challenge194
  where
import Data.Maybe ( fromJust )
import Data.List ( findIndex , (!!))
import Data.Char ( digitToInt )

validHours :: [Int]
validHours = enumFromTo 0 23

validMinutes :: [Int]
validMinutes = enumFromTo 0 59

solution :: String -> Int
solution input = case pos of
0 -> until (\d -> elem (digitToInt ( input !! 1 ) + d * 10 ) validHours )
  pred d
1 -> until (\d -> elem (digitToInt ( input !! 0 ) * 10 + d ) validHours )
    pred d
3 -> until (\d -> elem (digitToInt ( input !! 4 ) + d * 10 ) validMinutes )
      pred d
4 -> until (\d -> elem (digitToInt ( input !! 3 ) * 10 + d ) validMinutes ) pred
      d
where
  d :: Int
  d = 9
  pos :: Int
  pos = fromJust $ findIndex ( == '?' ) input

keepAskingForInput :: IO String
keepAskingForInput = do
  putStrLn "Enter a time in the form hh:mm, with 1 position replaced by a '?'"
  myLine <- getLine
  if '?' `elem` myLine then return myLine
  else do
      keepAskingForInput

main :: IO ( )
main = do
  theInput <- keepAskingForInput
  print $ solution theInput
