module Challenge328
   where
import Data.List ( findIndices , (\\) , (!!) ) 

change :: String -> String   
change str = 
   let position = head $ findIndices (== '?' ) str
       left = if position > 0 then position - 1 else 0
       l    = length str
       right = if position < l - 1 then position + 1 else l - 1
       remaining = ['a'..'z'] \\ [str !! left , str !! right]
   in take position str ++ [head remaining] ++ drop ( position + 1 ) str

main :: IO ( )
main = do
   putStrLn "Enter a string with lowercase English letters and one ?!" 
   wordline <- getLine
   print $ change wordline
