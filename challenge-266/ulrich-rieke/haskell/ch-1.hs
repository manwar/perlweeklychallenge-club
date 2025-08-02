module Challenge266
   where
import qualified Data.Set as S

solution :: String -> String -> [String]
solution s1 s2 = 
   let firstWords = words s1
       secondWords = words s2
       allWords = S.toList $ S.fromList (firstWords ++ secondWords)
       frequencies = map (\w ->(w , (length $ filter ( == w ) firstWords) + (length $ 
        filter ( == w ) secondWords ) ) ) allWords
   in if null frequencies then [] else map fst $ filter ( (== 1 ) . snd ) frequencies    

main :: IO ( ) 
main = do
   putStrLn "Enter some words, separated by blanks!" 
   firstWords <- getLine
   putStrLn "Enter some more words, separated by blanks!"
   secondWords <- getLine
   print $ solution firstWords secondWords
