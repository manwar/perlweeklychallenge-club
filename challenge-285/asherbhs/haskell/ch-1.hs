import Data.Set (Set)
import qualified Data.Set as Set
import Data.Function (on)

noConnection :: [(Char, Char)] -> Char
noConnection routes
    = head
    $ Set.toList
    $ ((Set.\\) `on` Set.fromList) 
        (map snd routes)
        (map fst routes)

main :: IO ()
main = do
    print $ noConnection [('B', 'C'), ('D', 'B'), ('C', 'A')]
    print $ noConnection [('A', 'Z')]
