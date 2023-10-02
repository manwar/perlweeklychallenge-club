module Challenge224
  where
import qualified Data.Set as S
import Data.Maybe ( fromJust )

solution :: String -> String -> Bool
solution source target = S.isSubsetOf tset sset &&  ( all (\c ->
(fromJust $ lookup c occurrencesTarget) <= ( fromJust $ lookup
c occurrencesSource )) $ S.toList tset )
where
  tset :: S.Set Char
  tset = S.fromList target
  sset :: S.Set Char
  sset = S.fromList source
  count :: Char -> String -> Int
  count c str = length $ filter ( == c ) str
  occurrencesTarget :: [(Char, Int)]
  occurrencesTarget = zip ( S.toList tset ) ( map (\b -> count b target )
  $ S.toList tset )
  occurrencesSource :: [(Char , Int)]
  occurrencesSource = zip ( S.toList sset ) ( map (\b -> count b source )
  $ S.toList sset )

main :: IO ( )
main = do
  putStrLn "Enter a source string!"
  source <- getLine
  putStrLn "Enter a target string!"
  target <- getLine
  if solution source target then print "true" else print "false"
