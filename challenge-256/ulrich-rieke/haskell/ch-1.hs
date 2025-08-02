module Challenge256
   where
import qualified Data.Set as S

solution :: [String] -> Int
solution strings = 
   let ortho = S.fromList strings
       reversed = S.fromList $ map reverse strings
   in div ( S.size $ S.intersection ortho reversed ) 2

main :: IO ( ) 
main = do
   putStrLn "Enter some strings, separated by blanks!"
   line <- getLine
   print $ solution $ words line
