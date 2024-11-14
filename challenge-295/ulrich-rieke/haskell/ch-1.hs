module Challenge295
   where
import Data.List ( isInfixOf )
import Data.List.Split ( divvy ) 
import qualified Data.Set as S

findPositionsInWord :: String -> String -> [Int]
findPositionsInWord total part = filter (\i -> (take lp $ drop i total) == part)
 [0..length total - lp]
  where
   lp = length part

matchIndices :: String -> String -> ([Int] , String)
matchIndices total part = (findPositionsInWord total part , part)

findAllIndices :: ([Int] , String) -> [[Int]]
findAllIndices pair = map (\i -> [i..i + length ( snd pair ) - 1] ) $ fst pair

solution :: String -> [String] -> Bool
solution totaltext parts
   |any (\w -> not $ isInfixOf w totaltext ) parts = False
   |otherwise = all (\vec -> S.null $ S.intersection ( S.fromList ( head vec ) ) 
     (S.fromList ( last vec ) ) ) $ divvy 2 1 $ concat allIndices
    where
     wordIndices :: [([Int] , String)]
     wordIndices = map (\s -> matchIndices totaltext s) parts
     allIndices :: [[[Int]]]
     allIndices = map findAllIndices wordIndices

main :: IO ( ) 
main = do
   putStrLn "Enter a long word!" 
   longline <- getLine
   putStrLn "Enter some words separated by whitespace!"
   wordline <- getLine
   print $ solution longline ( words wordline ) 
