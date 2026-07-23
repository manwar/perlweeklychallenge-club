module Challenge382_2
   where
import Data.List ( findIndices , sort , subsequences , (!!))
import qualified Data.Set as S

findAllCombis :: Int -> [String]
findAllCombis n = S.toList $ S.fromList $ filter ( (== n ) . length ) $ subsequences
 $ take ( 2 * n ) $ cycle "01"

replaceWord :: String -> String -> String
replaceWord original replacement = 
   let helperString = replicate ( length original ) 'A'
       helperZipped = zip [0, 1 ..] helperString
       questionPos = findIndices ( == '?' ) original
       replacePart  = map (\p -> if elem ( fst p ) questionPos then replacement 
             !! ( head $ findIndices ( == ( fst p )) questionPos ) else 'A' )
        helperZipped
   in map (\p -> if snd p == 'A' then fst p else snd p ) $ zip original
    replacePart

solution :: String -> [String] 
solution input = 
  let questioncount = length $ findIndices ( == '?' ) input
      allCombis = if questioncount > 0 then findAllCombis questioncount else []
  in if null allCombis then [input] else sort $ map ( replaceWord input ) allCombis

main :: IO ( )
main = do
  putStrLn "Enter a word consisting of 0 , 1 and ? only!"
  word <- getLine
  print $ solution word
