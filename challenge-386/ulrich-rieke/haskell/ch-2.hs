module Challenge386_2
   where
import Data.List ( init  )
import Data.List.Split ( splitOn )

parse :: String -> [String]
parse str = 
   let [prepoint , remainder] = splitOn "." str
   in if null remainder then [prepoint , "" , ""] else [prepoint] ++ 
      splitOn "(" remainder

expand :: [String] -> String
expand [prepoint , singlepart , multipart] = prepoint ++ "." ++ 
 singlepart ++ ( take ( (length multipart - 1 ) * 4 ) $ cycle $ init
  multipart )     

solution :: String -> String -> Bool
solution firststring secondstring = 
   let [firstpre , firstsingle , firstmulti] = parse firststring
       [secondpre , secondsingle , secondmulti] = parse secondstring
       firstexpanded = expand [firstpre , firstsingle , firstmulti ]
       secondexpanded = expand [secondpre , secondsingle , secondmulti ]
   in if and [null secondsingle , null secondmulti , all ( == '9' ) 
    firstsingle || null firstsingle , all ( == '9' ) $ init firstmulti] then
     (read secondpre :: Int) == (read firstpre :: Int) + 1 else 
      ((take ( length secondexpanded ) firstexpanded) == secondexpanded )
       || ( take ( length firstexpanded ) secondexpanded ) == 
         firstexpanded 

main :: IO ( )
main = do
   putStrLn "Enter a rational number!"
   rat1 <- getLine
   putStrLn "Enter another rational number!"
   rat2 <- getLine
   print $ solution rat1 rat2
