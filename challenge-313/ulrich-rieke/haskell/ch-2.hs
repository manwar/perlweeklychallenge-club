module Challenge313_2
   where
import Data.Char ( isAlpha ) 
import Data.List ( partition , sortOn)

--solution is not as straightforward as in a procedural language
--we first separated alphabetic and non-alphabetic letters after zipping
--them with natural numbers
--then we reverse the alphabetic numbers and zip their corresponding
--first original numbers
--after swapping these, we form a new list with the non-alphabetic numbers
--and sort them on their position!
solution :: String -> String
solution str = 
   let zipped = zip [0 , 1 ..] str
       (alphas , noAlphas ) = partition ( isAlpha . snd ) zipped
       reversedAlphas = reverse alphas
       old_new_positions = zip ( map fst alphas ) ( map fst reversedAlphas )
       new_old_pos = map(\p -> (snd p, fst p) ) old_new_positions
       newCharPositions = zip ( map fst new_old_pos ) ( map snd alphas )
       rearranged = newCharPositions ++ noAlphas
   in map snd $ sortOn fst rearranged

main :: IO ( )
main = do
   putStrLn "Enter a string!"
   myString <- getLine
   print $ solution myString
