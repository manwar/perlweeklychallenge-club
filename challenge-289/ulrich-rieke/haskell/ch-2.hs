module Challenge289_2
   where
import System.Random
import Data.List (init , tail , (!!)) 
import Control.Applicative 

keepRolling :: Int -> [Int] 
keepRolling n = snd $ until ( null . fst ) transferOne ([0..n - 1] , [] )
 where
  transferOne :: ([Int] , [Int] ) -> ([Int] , [Int]) 
  transferOne ( fromList , toList ) = (take selected fromList ++ drop ( selected 
   + 1 ) fromList , toList ++ [( fromList !! selected )]) 
   where
    selected = fst $ uniformR (0 , length fromList - 1) (mkStdGen 137 )  

shuffle :: String -> String
shuffle s 
   |length s <= 3 = s 
   |otherwise = [head s] ++ shuffled ++ [last s]
    where
     randomIndices :: [Int]
     randomIndices = keepRolling ( length s - 2 )
     shuffled :: String
     shuffled = map (\i -> ( init $ tail s ) !! i ) randomIndices 

enterLines :: IO [String]
enterLines = do
   line <- getLine
   if null line then return []
   else (line : ) <$> enterLines
   
main :: IO ( ) 
main = do
   putStrLn "Enter some sentences, <return> to end!" 
   sentences <- enterLines
   let shuffled = map(\s -> unwords $ map shuffle $ words s) sentences 
   mapM_ putStrLn shuffled
