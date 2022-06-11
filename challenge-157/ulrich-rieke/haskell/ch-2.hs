module Challenge157_2
  where
import Data.Maybe ( fromJust )
import Control.Monad.State.Lazy
import Data.Char ( intToDigit )

findBases :: Int -> State ( Int , String ) String
findBases theBase = do
  (number , basenumberstring) <- get
  if number == 0
      then return (reverse basenumberstring)
  else do
      put ( div number theBase , basenumberstring ++
            [ fromJust $ lookup ( mod number theBase ) positions ] )
      findBases theBase

convertToBase :: Int -> Int -> String
convertToBase number base = evalState (findBases base ) ( number , [] )

positions :: [(Int , Char) ]
positions = zip [0..35] ( (map intToDigit [0..9]) ++ ['A'..'Z'] )

isBrazilian :: Int -> Bool
isBrazilian n = any allSame $ map (\i -> convertToBase n i ) [2 .. n - 2]
where
  allSame :: String -> Bool
  allSame s = all (\c -> c == ( head s )) s

askForCorrectNumber ::IO Int
askForCorrectNumber = do
  putStrLn "Please enter an integer greater than 3 and smaller than 39!"
  num <- getLine
  let n = read num
  if (n > 3 && n < 39) then return n
  else do
      askForCorrectNumber

main :: IO ( )
main = do
  n <- askForCorrectNumber
  if isBrazilian n then putStrLn "1" else putStrLn "0"
