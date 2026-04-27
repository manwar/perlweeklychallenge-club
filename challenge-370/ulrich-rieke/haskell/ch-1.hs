module Challenge370
   where
import Data.Char( toLower , isPunctuation )
import qualified Data.Set as S
import Data.List ( findIndices , sortOn) 

convert :: String -> String
convert = map toLower . filter ( not . isPunctuation )

--if there is no space as separator, accept punctuation   
punctAsSeparator :: String -> String
punctAsSeparator = map (\c -> if isPunctuation c then ' ' else c)

solution :: String -> [String] -> String
solution paragraph banned =
   let allWords = words paragraph
       converted = if length allWords > 1 then map convert allWords else 
        map convert $ words $ punctAsSeparator paragraph
       frequencies = map (\w -> ( w, length $ findIndices ( == w )
        converted )) $ S.toList $ S.fromList $ filter ( flip notElem banned
         ) converted
   in fst $ last $ sortOn snd frequencies  

main :: IO ( )
main = do
   putStrLn "Enter a paragraph!"
   paragraph <- getLine
   putStrLn "Enter some banned words separated by blanks!"
   bannedline <- getLine
   print $ solution paragraph ( words bannedline )
        
