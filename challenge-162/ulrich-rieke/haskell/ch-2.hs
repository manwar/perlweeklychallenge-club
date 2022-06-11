module Challenge162_2
  where
import Data.List.Split( chunksOf , splitOn )
import Data.List ( elemIndex , nub , (!!) , (\\) , group , intercalate )
import Data.Maybe ( fromJust )

makeGrid :: String -> String
makeGrid seedPhrase = phrase ++ ( alphabet \\ phrase )
where
  phrase :: String
  phrase = nub $ foldl1 ( ++ ) $ splitOn " " seedPhrase
  alphabet :: String
  alphabet = ['a' .. 'i'] ++ ['k' .. 'z']

--given a position number , in which row of the grid are we ?
findRow :: Int -> Int
findRow n = div ( n - ( mod n 5 )) 5

--given a position number , in which column of the grid are we ?
findColumn :: Int -> Int
findColumn n = mod n 5

encodeOnSameRow :: String -> Char -> Char
encodeOnSameRow keyphrase letter = if findRow ( pos + 1 ) == findRow pos
then keyphrase !! ( pos + 1 ) else keyphrase !! ( pos - 4 )
where
  pos :: Int
  pos = fromJust $ elemIndex letter keyphrase

encodeOnSameColumn :: String -> Char -> Char
encodeOnSameColumn keyphrase letter
  |pos + 5 > 25 = keyphrase !! ( mod pos 5 )
  |otherwise    = keyphrase !! ( pos + 5 )
  where
    pos :: Int
    pos = fromJust $ elemIndex letter keyphrase

encodeOnRectangle :: String -> String -> String
encodeOnRectangle keyPhrase toBeEncrypted = [keyPhrase !! ( row1 * 5 + col2 ),
  keyPhrase !! (row2 * 5 + col1)]
  where
  pos1 :: Int
  pos1 = fromJust $ elemIndex ( head toBeEncrypted ) keyPhrase
  pos2 :: Int
  pos2 = fromJust $ elemIndex ( last toBeEncrypted ) keyPhrase
  row1 :: Int
  row1 = findRow pos1
  row2 :: Int
  row2 = findRow pos2
  col1 :: Int
  col1 = findColumn pos1
  col2 :: Int
  col2 = findColumn pos2

decodeOnSameRow :: String -> Char -> Char
decodeOnSameRow keyPhrase letter = if findRow ( pos - 1 ) == findRow pos
then keyPhrase !! ( pos - 1 ) else keyPhrase !! ( pos + 4 )
where
  pos :: Int
  pos = fromJust $ elemIndex letter keyPhrase

decodeOnSameColumn :: String -> Char -> Char
decodeOnSameColumn keyPhrase letter
  |pos - 5 < 0 = keyPhrase !! ( 20 + findColumn pos )
  |otherwise  = keyPhrase !! ( pos - 5 )
  where
    pos :: Int
    pos = fromJust $ elemIndex letter keyPhrase

decodeOnRectangle :: String -> String -> String
decodeOnRectangle keyPhrase toBeDecrypted = [keyPhrase !! (row1 * 5 + col2) ,
keyPhrase !! (row2 * 5 + col1)]
where
  pos1 :: Int
  pos1 = fromJust $ elemIndex ( head toBeDecrypted ) keyPhrase
  pos2 :: Int
  pos2 = fromJust $ elemIndex ( last toBeDecrypted ) keyPhrase
  row1 :: Int
  row1 = findRow pos1
  row2 :: Int
  row2 = findRow pos2
  col1 :: Int
  col1 = findColumn pos1
  col2 :: Int
  col2 = findColumn pos2

substitute :: String -> Char -> Char -> String
substitute word from to = map (\c -> if c == from then to else c ) word

insertAfterDoubleLetters :: String -> String
insertAfterDoubleLetters str = foldl1 ( ++ ) $  map (\li -> if length li > 1
then intercalate "x" $ map (\c -> [c]) li  else li) $ group str

hackApart :: String -> [String]
hackApart word
  |odd $ length word = map (\li -> if head li == last li then [head li , 'x']
    else li) $ chunksOf 2 ( word ++ ['x'] )
  |otherwise = map (\li -> if head li == last li then [head li , 'x'] else
    li)  $ chunksOf 2 word

encrypt :: String -> String -> String
encrypt keyPhrase toBeEncrypted = foldl1 (++) $ map(\li -> encryptPair li ) $
hackApart toBeEncrypted
where
  encryptPair :: String -> String
  encryptPair pair
  |findColumn pos1 == findColumn pos2 = map (\c -> encodeOnSameColumn keyPhrase c)
    pair
  |findRow pos1 == findRow pos2 = map (\c -> encodeOnSameRow keyPhrase c) pair
  |otherwise = encodeOnRectangle keyPhrase pair
  where
    pos1 :: Int
    pos1 = fromJust $ elemIndex ( head pair ) keyPhrase
    pos2 :: Int
    pos2 = fromJust $ elemIndex ( last pair ) keyPhrase

decrypt :: String -> String -> String
decrypt keyPhrase toBeDecrypted = foldl1 (++) $ map (\li -> decryptPair li ) $
hackApart toBeDecrypted
where
  decryptPair :: String -> String
  decryptPair pair
  |findColumn pos1 == findColumn pos2 = map (\c -> decodeOnSameColumn keyPhrase
    c) pair
  |findRow pos1 == findRow pos2 = map (\c -> decodeOnSameRow keyPhrase c ) pair
  |otherwise = decodeOnRectangle keyPhrase pair
  where
    pos1 :: Int
    pos1 = fromJust $ elemIndex ( head pair ) keyPhrase
    pos2 :: Int
    pos2 = fromJust $ elemIndex ( last pair ) keyPhrase

main :: IO ( )
main = do
  putStrLn "Please enter a key phrase from which to construct the grid!"
  phrase <- getLine
  putStrLn "Which text do you want to encrypt?"
  toBeEncrypted <- getLine
  let grid = makeGrid phrase
      toBeEncryptedRed = insertAfterDoubleLetters $ substitute ( foldl1 ( ++ )
    $ splitOn " " toBeEncrypted) 'j' 'i'
  putStrLn toBeEncryptedRed
  putStrLn $ encrypt grid toBeEncryptedRed
  putStrLn "Enter another key phrase!"
  secondPhrase <- getLine
  putStrLn "Which text do you want to decrypt?"
  toBeDecrypted <- getLine
  putStrLn $ decrypt (makeGrid secondPhrase) toBeDecrypted
