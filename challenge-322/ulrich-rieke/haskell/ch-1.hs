module Challenge322
   where
import Data.List.Split ( chunksOf ) 
import Data.List ( intercalate ) 

solution :: String -> Int -> String
solution str num = 
   let noHyphens = filter ( /= '-' ) str
       firstlen = mod ( length noHyphens ) num
       allChunks = if firstlen /= 0 then [take firstlen noHyphens] ++
        chunksOf num ( drop firstlen noHyphens ) else chunksOf num 
	 noHyphens
   in intercalate "-" allChunks

main :: IO ( )
main = do
   putStrLn "Enter a string and a positive integer separated by blanks!"
   line <- getLine
   let expressions = words line
   print $ solution ( head expressions ) ( read $ last expressions )
