module Challenge090
  where
import Data.Maybe ( fromJust )

count :: Eq a => a -> [a] -> Int
count c [] = 0
count d ( x:xs )
  |d == x = 1 + count d xs
  |otherwise = count d xs

pairings :: [(Char ,  Char ) ]
pairings = [('C' , 'G') , ('A' , 'T' ) , ('T' , 'A' ) , ('G' , 'C')]

frequencies :: String -> [(Char , Int)]
frequencies sequence = map (\c -> (c , count c sequence )) "ACTG"

findComplement :: String -> String
findComplement sequence = map (\c -> fromJust $ lookup c pairings )
sequence

convert :: (Char , Int ) -> String
convert p = [fst p] ++ ": " ++ (show $ snd p)

main :: IO ( )
main = do
  putStrLn "Enter the sequence!"
  sequence <- getLine
  let freq = frequencies sequence
      complement = findComplement sequence
  mapM_ putStrLn $ map convert freq
  putStrLn ("complement: " ++ complement)
