module Challenge361
   where
import Data.List ( find , findIndices , (!!))
import Data.Maybe ( fromJust ) 
import Control.Monad.State   

fibonacci :: Int -> Int
fibonacci n
   |n == 0 || n == 1 = n
   |n > 1 = fibonacci (n - 2 ) + fibonacci ( n - 1 )

fibonaccis :: [Int]
fibonaccis = map fibonacci [0..12]

solution :: State ([Int] , Int) [Int]
solution = do
   (startlist , startnumber) <- get
   let rev = reverse fibonaccis
   if startnumber == 0 then return startlist
   else do
      put ( startlist ++ [fromJust $ find ( <= startnumber ) rev ] ,
       startnumber - ( rev !! ( head $ findIndices (<= startnumber )
        rev )))
      solution

output :: Int -> [Int]
output number = evalState solution ([] , number)

main :: IO ( )
main = do
   putStrLn "Enter a number not greater than 100!" 
   numberline <- getLine
   print $ output $ read numberline

