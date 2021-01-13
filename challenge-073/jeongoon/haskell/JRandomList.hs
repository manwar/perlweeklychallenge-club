module JRandomList
  ( shuffleByPickingAll,
  ) where

import Data.List ( unfoldr, splitAt, tails )
import System.Random ( randomR, Random, StdGen )
import System.Environment (getArgs)


{- Ref:
https://www.schoolofhaskell.com/school/starting-with-haskell/libraries-and-frameworks/randoms
https://hackage.haskell.org/package/containers-0.6.3.1/docs/Data-Sequence.html
https://stackoverflow.com/questions/9834433/convert-data-sequence-to-a-list
https://hackage.haskell.org/package/base-4.12.0.0/docs/Data-List.html
https://en.wikibooks.org/wiki/Haskell/Libraries/Random
https://hackage.haskell.org/package/optparse-generic-1.2.3/docs/Options-Generic.html
-}

descendingRandomR :: (Integral a, Ord a, Random a) =>
                  ((a,   a), StdGen) -> Maybe (a, ((a, a), StdGen))
descendingRandomR ((lo, hi), g) =
  let (rv, g') = randomR (lo, hi) g -- rv: random value from seed(g)
      hi' = hi - 1
  in if lo > hi then Nothing else Just (rv, ((lo, hi'), g'))

indicesToPick :: (Integral a, Random a) =>
  a -> StdGen -> [a] -- input: <highest value> <seed>
indicesToPick = (curry.curry $ unfoldr descendingRandomR) 0 -- 0: first index

popAt :: Int -> [a] -> (Maybe a, [a])
popAt = curry $ (\(le, ri) ->
                    ( if null ri then Nothing else Just (head ri),
                      le ++ tail ri ) ) . (uncurry splitAt)

poping :: ([a], [Int]) -> Maybe (a, ([a], [Int]))
poping ([], _) = Nothing
poping (_, []) = Nothing
poping (ls, idcs) =
  let (e, ls') = popAt (head idcs) ls
      idcs' = tail idcs
  in case e of
      Nothing  -> poping (ls', idcs') -- skip the index which is out of range
      Just e'  -> Just (e', (ls', idcs'))

shuffleByPickingAll :: [a] -> StdGen -> [a]
shuffleByPickingAll ls seed = pick (ls, ( indicesToPick maxIdx seed ))
  where
    pick = unfoldr poping
    maxIdx = ( length ls ) - 1
