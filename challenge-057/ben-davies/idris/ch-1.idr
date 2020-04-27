module Main

import Data.String.Extra

%default total

data Tree a = Node a | Branch a (Tree a) (Tree a)

private
showTree : Show a => (n : Nat) -> (t : String) -> Tree a -> String
showTree n t (Node a)       = indent (n * 2) t ++ " " ++ show a
showTree n t (Branch a l r) = indent (n * 2) t ++ " " ++ show a ++ "\n" ++
                              showTree (n + 1) "L" l ++ "\n" ++
                              showTree (n + 1) "R" r

implementation Show a => Show (Tree a) where
    show = showTree 0 "T"

-- Inverts a tree.
invert : Tree a -> Tree a
invert (Node a)       = Node a
invert (Branch a l r) = Branch a (invert r) (invert l)

main : IO ()
main = printLn $ invert $ Branch 1 (Branch 2 (Node 4) (Node 5)) (Branch 3 (Node 6) (Node 7))
