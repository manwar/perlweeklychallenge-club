module Challenge274_2
   where
import Data.List ( (!!) , sortOn) 

--when does the next bus line leave ?
findNextStart :: Int -> [Int] -> Int
findNextStart minute busschedule = head $ dropWhile ( < minute ) $
 iterate ( + busschedule !! 0 ) (busschedule !! 1 )    

--which lines come next , in order of start   
nextStarts :: Int -> [[Int]] -> [(Int , Int)]
nextStarts minute schedule = sortOn snd $ map (\(i , sched ) -> (i ,
 findNextStart minute sched )) $ zip [0 , 1 ..] schedule 

--when do the next buses arrive, in order of start ? 
findArrivals :: Int -> [[Int]] -> [Int] 
findArrivals minute schedule = 
   let starts = nextStarts minute schedule
   in map (\( i , d ) -> d + schedule !! i !! 2 ) starts 

--let one bus leave if the first bus arrives in town later ,
--provided they do not start at the same time and arrive at the
--same time
letOnePass :: Int -> [[Int]] -> Bool
letOnePass minute schedule = 
   let starts = nextStarts minute schedule
       firstLines = ( snd $ starts !! 0 , snd $ starts !! 1 )
       arrivals = map (\(i , d) -> d + schedule !! i !! 2 ) starts
   in (fst firstLines /= snd firstLines) && ( minimum arrivals == arrivals 
      !! 1 ) && ( arrivals !! 0 /= arrivals !! 1 )

enterNLines :: Int -> IO [String]
enterNLines n 
   |n <= 0 = return []
   |otherwise = do
      putStrLn "Enter some integers, separated by blanks!"
      x <- getLine
      xs <- enterNLines ( n - 1 )
      let ret = (x:xs)
      return ret  

solution :: [[Int]] -> [Int]
solution schedule = filter (\i -> letOnePass i schedule ) [0..59]
   
main = do
   putStrLn "Enter some bus schedules!( interval , offset , drive time! )"
   putStrLn "For how many bus lines do you want to enter schedules ?"
   linenumber <- getLine
   buslines <- enterNLines ( read linenumber )
   let schedule = map ( map read . words ) buslines
   print $ solution schedule  
