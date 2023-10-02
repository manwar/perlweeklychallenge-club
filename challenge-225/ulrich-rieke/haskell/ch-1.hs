module Challenge225
  where
import Data.Char( isSpace )
import Control.Monad.State

isValid :: String -> Bool
isValid str = (not $ isSpace $ head str) && ( not $ isSpace $ last str )

askForInput :: IO String
askForInput = do
  putStrLn "Enter a sentence without trailing spaces, fin to end!"
  line <- getLine
  if (isValid line ) then pure line
  else
      askForInput

enterStrings :: StateT [String] ( IO )[String]
enterStrings = do
  sentences <- get
  sentence <- lift $ askForInput
  if sentence == "fin" then return sentences
  else do
    modify (++ [sentence])
    enterStrings

solution :: [String] -> Int
solution strings = maximum $ map ( length . words ) strings

main :: IO ( )
main = do
  strings <- execStateT enterStrings []
  print $ solution strings
