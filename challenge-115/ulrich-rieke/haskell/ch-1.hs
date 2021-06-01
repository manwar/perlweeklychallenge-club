module Challenge115
  where
import Data.List ( nub , sortOn)

count :: Eq a => a -> [ a ] -> Int
count d theList = length $ filter ( == d ) theList

solution :: [String] -> Int
solution theList = if countStart == countEnd then 1 else 0
where
  startletters :: [Char]
  startletters = map head theList
  countStart :: [ (Char , Int) ]
  countStart = sortOn fst $ map (\c -> ( c , count c startletters ))
    $ nub startletters
  endletters :: [Char]
  endletters = map last theList
  countEnd :: [ (Char , Int) ]
  countEnd = sortOn fst $ map (\c -> ( c, count c endletters ) )
    $ nub endletters
