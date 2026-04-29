module Challenge371
   where
import Data.Char ( ord , chr )
import qualified Data.Set as S
import Data.List ( findIndices , (!!) ) 
import Data.List.Split ( divvy )

solution :: [Char] -> Char   
solution letters =
   let question_pos = head $ findIndices ( == '?' ) letters
       letterpairs = divvy 2 1 letters
       selected = filter (\p -> head p /= '?' && ( last p /= '?' )) letterpairs
       differences = map (\p -> (ord $ last p) - ( ord $ head p )) selected
       uniques = S.toList $ S.fromList differences
       newDiffs = take 4 $ cycle $ take 2 differences 
   in if length uniques == 1 then 
       if question_pos == 0 then chr ((ord $ letters !! 1) - head differences ) 
       else chr (ord (letters !! ( question_pos - 1 )) + head differences )
      else if question_pos == 0 then chr( (ord $ letters !! 1 ) - head newDiffs )
           else chr ( (ord $ letters !! (question_pos - 1)) + newDiffs !! ( 
                    question_pos - 1 ) ) 

--a string is a type synonym for [Char]           
main :: IO ( )
main = do
   print $ solution "ac?gi"
   print $ solution "ad?jm"
   print $ solution "ae?mq"
   print $ solution "acf?k" 
   print $ solution "beg?l"
