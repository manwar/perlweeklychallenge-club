import Data.List
import Data.Char 

(f .: g) x y = f (g x y)
infixr 8 .:

reorderNotes :: String -> [String] -> [Int] -> String 
reorderNotes composer notes permutation = map toUpper composer
                                       ++ " => "
                                       ++ processNotes notes permutation 
  where
    processNotes :: [String] -> [Int] -> String   
    processNotes = unwords   
                 . map fst 
                 . sortOn snd .: zip 
main :: IO ()
main = do
  print $ reorderNotes "Bach" ["C", "D", "E", "F#", "G", "A", "B"] [7, 1, 6, 2, 5, 3, 4]
        == "BACH => D F# A B G E C"

  print $ reorderNotes "Beethoven" ["C", "D", "F#", "G", "Ab"] [1, 3, 5, 2, 4]
        == "BEETHOVEN => C G D Ab F#"

  print $ reorderNotes "Brahms" ["C", "Db", "Eb", "F", "G", "Ab", "Bb", "C", "D"] [9, 3, 7, 1, 8, 5, 2, 6, 4]
        == "BRAHMS => F Bb Db D Ab C Eb G C"

  print $ reorderNotes "Bruckner" ["G", "F#", "Bb", "C", "D", "Eb", "F"] [4, 7, 2, 6, 1, 5, 3]
        == "BRUCKNER => D Bb F G Eb C F#"

  print $ reorderNotes "Berg" ["C#"] [1]
        == "BERG => C#"
