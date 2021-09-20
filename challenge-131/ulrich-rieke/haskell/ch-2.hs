module Challenge131_2
  where

solution :: String -> String -> (String, String)
solution delimiters searchstring = ( filter (\c -> elem c openings)
searchstring , filter ( \c -> elem c closings ) searchstring )
where
  pairs :: [( Int , Char )]
  pairs = zip [0, 1 ..] delimiters
  openings :: String
  openings = map snd $ filter ( even . fst ) pairs
  closings :: String
  closings = map snd $ filter ( odd . fst ) pairs

main :: IO ( )
main = do
  putStrLn "Enter delimiters!"
  delimiters <- getLine
  putStrLn "Enter search string!"
  searchstring <- getLine
  (fstPart, secondPart) <- return $ solution delimiters searchstring
  putStrLn fstPart
  putStrLn secondPart
