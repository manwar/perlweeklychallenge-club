module Challenge348_2
   where
import Data.List ( sort )

ops :: [Int]
ops = [1 , 5 , 15 , 60]

findDiffMinutes :: String -> String -> Int
findDiffMinutes source target =
   let sourcehours = read $ take 2 source
       sourceminutes = read $ take 2 $ drop 3 source
       targethours = read $ take 2 target
       targetminutes = read $ take 2 $ drop 3 target
   in if targethours < sourcehours then ( targethours + 24 ) * 60 + targetminutes
    - ( sourcehours * 60 + sourceminutes ) else targethours * 60 + targetminutes
     - ( sourcehours * 60 + sourceminutes )

findOps :: Int -> Int
findOps diffMinutes = head $ sort $ map sumTuple $ [(a , b , c , d) | a <- [0..
 diffMinutes] , b <- [0..div diffMinutes 5] , c <- [0..div diffMinutes 15] , d <-
  [0..div diffMinutes 60] , a * 1 + b * 5 + c * 15 + d * 60 == diffMinutes]
   where 
      sumTuple :: (Int , Int , Int , Int ) -> Int
      sumTuple ( a , b , c  , d) = a + b + c + d

main :: IO ( )
main = do
   putStrLn "Enter a source time!"
   sourcetime <- getLine
   putStrLn "Enter a target time!"
   targettime <- getLine
   let diffMinutes = findDiffMinutes sourcetime targettime
   print $ findOps diffMinutes
  
