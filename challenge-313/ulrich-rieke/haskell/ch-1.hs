module Challenge313
   where
import qualified Data.Set as S

solution :: String -> String -> Bool
solution firstStr secondStr = firstset == secondset && ( length firstStr 
 /= length secondStr )
 where
  firstset = S.fromList firstStr
  secondset = S.fromList secondStr

main :: IO ( )
main = do
   putStrLn "Enter a word!" 
   firstWord <- getLine
   putStrLn "Enter a second word with possible typing errors!"
   secondWord <- getLine
   print $ solution firstWord secondWord
