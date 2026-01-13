module Challenge356_2
   where
import Data.List ( sort , (!!) )
    
findTies :: String -> [(Int , Int)] -> [Int]   
findTies results ties =
   let zipped = zip results ties
   in sort $ map (\p -> if fst p == 'H' then fst $ snd p else snd $ snd p ) zipped 

finalResult :: String -> String
finalResult allResult = 
   let first_seeding_list = findTies ( take 3 allResult ) [(2 , 7) , (3 , 6 ) , (4 , 5)]
       second_seeding_list = findTies ( take 2 $ drop 3 allResult ) [(1 , 
        first_seeding_list !! 2) , (first_seeding_list !! 0 , first_seeding_list !! 1)]
       decider = last allResult
   in if decider == 'H' then "Team " ++ ( show $ head second_seeding_list) ++ " defeated "
    ++ "Team " ++ ( show $ last second_seeding_list ) else "Team " ++ ( show $ last 
     second_seeding_list ) ++ " defeated Team " ++ ( show $ head second_seeding_list )

main :: IO ( ) 
main = do
   print $ finalResult "HAHAHH"
   print $ finalResult "HHHHHH"
   print $ finalResult "HHHAHA"
   print $ finalResult "HAHAAH"
   print $ finalResult "HAAHAA"
