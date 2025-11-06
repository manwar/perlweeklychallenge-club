module Challenge346
   where
import Data.List ( findIndices , sortOn)

findValidLength :: String -> Int
findValidLength parens =
   let l = length parens
       bracketcount = map (\i -> (i , (length $ findIndices ( == '(' ) 
         $ take i parens , length $ findIndices ( == ')' ) $ take i 
	  parens ))) [2..l]
       selected = filter (\p ->  (fst $ snd p) - ( snd $ snd p ) == 0 ) 
        bracketcount
   in if null selected then 0 else fst $ last $ sortOn fst selected	

solution :: String -> Int
solution str = maximum $ map (\i -> findValidLength $ drop i str ) $ filter (\i -> 
  i < l - 1 ) $ findIndices ( == '(' ) str    
   where
    l = length str

main :: IO ( )
main = do
   putStrLn "Enter a word consisting of parentheses only!"
   parWord <- getLine
   print $ solution parWord
