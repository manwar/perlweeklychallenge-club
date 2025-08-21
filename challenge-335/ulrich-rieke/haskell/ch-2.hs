{-# LANGUAGE MultiWayIf #-}
module Challenge335_2
   where
import Data.List ( (!!) , transpose , findIndex , findIndices) 
import Data.Char ( digitToInt )
import Data.List.Split ( chunksOf  ) 

parseEntryLine :: String -> [(Int , Int)]
parseEntryLine line = map (\i -> ( digitToInt (line !! (i + 1 )) , digitToInt (line !! (i + 3 ))))
   $ findIndices ( == '[' ) line
   
tictacboard :: [String]
tictacboard = ["___" , "___" , "___"]

modifyBoard :: [String] -> (Int , (Int , Int)) -> [String]
modifyBoard board (n , p )
   |even n = if 
      |offset == 0 -> chunksOf 3 ( "A" ++ drop 1 letterrow )
      |offset > 0 && offset < 8 -> chunksOf 3 ( take offset letterrow ++ "A" ++ drop ( offset + 1 )
	    letterrow )
      |offset == 8 -> chunksOf 3 ( take 8 letterrow ++ "A" )
   |otherwise  = if 
      |offset == 0 -> chunksOf 3 ( "B" ++ drop 1 letterrow )
      |offset > 0 && offset < 8 -> chunksOf 3 ( take offset letterrow ++ "B" ++ drop ( offset + 1 )
	    letterrow )
      |offset == 0 -> chunksOf 3 ( take 8 letterrow ++ "B" )
     where
      letterrow = concat board
      offset = fst p * 3 + snd p

modifyTictacBoard coordinates =
   let zipped = zip [0 , 1 ..] coordinates
   in foldl modifyBoard tictacboard zipped

rowEqual :: [String] -> Bool
rowEqual board = any (\r -> all (\l -> l == r !! 0 && l /= '_' ) r ) board

columnEqual :: [String] -> Bool
columnEqual = rowEqual . transpose

oneDiagonal :: [String] -> Bool
oneDiagonal board = and [board !! 0 !! 0 == board !! 1 !! 1 , board !! 1 !! 1 == 
 board !! 2 !! 2 , board !! 1 !! 1 /= '_' ]

otherDiagonal :: [String] -> Bool
otherDiagonal board  = and [board !! 2 !! 0 == board !! 1 !! 1 , board !! 1 !! 1 == 
 board !! 0 !! 2 , board !! 1 !! 1 /= '_' ]

isDraw :: [String] -> Bool
isDraw board = 
   let values = [rowEqual board , columnEqual board , oneDiagonal board , otherDiagonal board] 
   in all (== False ) values && all (\r -> all ( (/= '_') ) r ) board
   
isPending :: [String] -> Bool
isPending board = 
   let values = [rowEqual board , columnEqual board , oneDiagonal board, otherDiagonal board,
                isDraw board] 
   in all (== False ) values

findOutput :: [String] -> String
findOutput board 
   |rowEqual board = case findIndex (\r -> all (\l -> l == (r !! 0)) r ) board of 
                      Just i -> [board !! i !! 0]
		      Nothing -> " "
   |columnEqual board = case findIndex(\r -> all (\l -> l == ( r !! 0 )) r ) transposed of
                        Just i -> [transposed !! i !! 0]
			Nothing -> " "
   |oneDiagonal board = [board !! 0 !! 0]
   |otherDiagonal board = [board !! 2 !! 0 ]
   |isDraw board = "Draw"
   |isPending board = "Pending"
   where
      transposed = transpose board 

main :: IO ( )
main = do
   putStrLn "Enter some numbers between 0 and 2 in brackets separated by commas!"
   numberline <- getLine
   let pairs = parseEntryLine numberline
       board = modifyTictacBoard pairs
   print $ findOutput board    
