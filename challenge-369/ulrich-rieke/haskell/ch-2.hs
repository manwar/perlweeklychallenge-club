module Challenge369_2
   where
import Data.List ( init , (!!) )
import Data.List.Split ( chunksOf )

solution :: String -> Int -> Char -> [String]
solution str size filler =
   let parts = chunksOf size str
       lastWord = last parts
       ll       = length lastWord
   in if ll < size then init parts ++ [ lastWord ++ replicate ( size - ll ) 
    filler ] else parts

main :: IO ( )
main = do
   putStrLn "Enter string , size and filler separated by blanks!"
   line <- getLine
   let theWords = words line
   print $ solution ( theWords !! 0 ) ( read $ theWords !! 1 ) ( head $ 
    theWords !! 2 )      
       
