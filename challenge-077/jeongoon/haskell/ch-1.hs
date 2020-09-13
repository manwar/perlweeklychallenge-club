{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
import Options.Generic
import Data.List (findIndex, intersect, intercalate, sortBy, unfoldr)

{- tested with:
runhaskell 99999 # total 192 case(s) (slower than perl code T.T)
-}
-- fib, fib2: credit: https://wiki.haskell.org/The_Fibonacci_sequence
fib = fst . fib2

-- | Return (fib n, fib (n + 1))
fib2 0 = (1, 1)
fib2 1 = (1, 2)
fib2 n
 | even n    = (a*a + b*b, c*c - a*a)
 | otherwise = (c*c - a*a, b*b + c*c)
 where (a,b) = fib2 (n `div` 2 - 1)
       c     = a + b

-- solution
fibNumbers n = unfoldr (\(x, i) -> let fn = fib i in
                          if fn <= x then Just(fn, (x, i+1))
                          else Nothing ) (n, 1)
reversedFibNumbers = sortBy (\a b -> compare b a).fibNumbers

-- find the all cases of a fib number can be expressed
divideAFib :: Integer -> [Integer] -> [[Integer]]
divideAFib f [] = divideAFib f (reversedFibNumbers f)
divideAFib f rfibNums =
  case (findIndex (f==) rfibNums) of
    Nothing   -> [] --  wrong fib number
    Just fidx -> [[f]] -- always include one fib number itself
                ++ unfoldr divideAFibInner (fidx, rfibNums, [f])
  where
    divideAFibInner (_, [], _) = Nothing -- only for silence warning message
    divideAFibInner (idx, rfs@(_:rfs'), acc)
      | idx +2 >= length rfs = Nothing
      | otherwise = Just ( acc', (idx+1, rfs', acc' ) )
      where
        nextTwoFibs = [ rfs !! (idx+1), rfs !! (idx+2) ]
        acc' = (init acc) ++ nextTwoFibs

rExpandFibCombination :: [Integer] -> [Integer] -> [[Integer]]
rExpandFibCombination rfibNumsCombi [] =
  rExpandFibCombination rfibNumsCombi (reversedFibNumbers (head rfibNumsCombi))
rExpandFibCombination rfibNumsCombi rAllFibNums =
  -- rfibNumsCombi: expect to get reversed sorted fib numbers
  filter ((0<).length) $
  unfoldr productExpandedCases ((replicate nof 0),
                                 lastCsr ) -- starting from last (smallest) fib.
  where
    rcases :: [[[Integer]]] -- list of each expanded list of a fib num
    rcases = unfoldr (\fibs
                        -> if null fibs then Nothing
                          else Just( divideAFib
                                  (head fibs) rAllFibNums,
                                  (tail fibs) ) ) rfibNumsCombi

    nof = length rfibNumsCombi
    lastCsr = nof - 1
    allNumRange = [ 0 .. lastCsr ]
    increaseAt    idx list =
      take idx list ++ ((list!!idx) +1) : drop (idx+1) -- increase pos at idx
      ( if idx == lastCsr then list
        else  take (idx+1) list ++ (replicate (lastCsr-idx) 0) )

    productExpandedCases :: ([Int], Int) -> Maybe ([Integer], ([Int], Int))
    productExpandedCases (pos, csr)
      | null pos       = Nothing
      | not isValidCase = Just ( [], (pos', csr') )
      | otherwise      =
          Just ( (foldr (++) [] rCaseCombi), (pos', csr') )
      where
        (pos', csr') = case nextCsr csr of
                         Nothing -> ([], csr) -- make edge case
                         Just c' -> (increaseAt c' pos,
                                    if csr == c' then c' else lastCsr )
                       -- not c' but lastCsr
                       -- because always rewind cursor after increase pos
                       -- at higher order number
                       -- e.g) increase at 2nd order 19 -> 20
                       -- after that increase 1st order -> 21

        rCaseAtCursor :: Int -> [Integer]
        rCaseAtCursor i = ((rcases!!i)!!(pos!!i))
        rCaseCombi = map rCaseAtCursor allNumRange

        isValidCase = isValidCaseInner (head rCaseCombi) (tail rCaseCombi)
          where
            isValidCaseInner _ [] = True
            isValidCaseInner leftCase (rightCase:moreRestCases)
              | (last leftCase) <= (head rightCase) = False
              | otherwise = isValidCaseInner rightCase moreRestCases


        fibAtCursorHasMoreCases c = ((length (rcases!!c)) -1) /= pos!!c

        nextCsr curcsr
          | fibAtCursorHasMoreCases curcsr = Just curcsr
          | curcsr < 1 = Nothing
          | otherwise = nextCsr (curcsr -1)

allCombiFibSum targetSum =
  case (minCombiFibSum targetSum 0 []) of
    Nothing -> []
    Just foundMinCombiSum -> rExpandFibCombination foundMinCombiSum rFibNumbers
  where
    rFibNumbers = reversedFibNumbers targetSum
    -- minCombiFibSum -> a combination of minimum number of fib. numbers
    minCombiFibSum tsum majorFibIdx minCombiAcc
      | majorFibIdx >= (length rFibNumbers) = Nothing -- no more fib
      | tsum < majorFib = minCombiFibSum -- try next available one
                           tsum (1+majorFibIdx) minCombiAcc
      | tsum == majorFib = Just $ minCombiAcc ++ [majorFib] -- exact match
      | null otherFibs   = Nothing -- run out of fib numbers
      | otherwise = -- go recursively until find other smaller fib numbers
          case (minCombiFibSum (tsum-majorFib) (1+majorFibIdx) []) of
            Nothing -> minCombiFibSum tsum (1+majorFibIdx) []
            Just foundMinCombiSum -> Just $ majorFib : foundMinCombiSum
      where
        majorFib = rFibNumbers !! majorFibIdx
        otherFibs = drop (1+majorFibIdx) rFibNumbers

-- testing
main = do
  args <- getRecord "Challenge #077 - Task #1"
  let targetSum = args :: Integer
      allCombi   = allCombiFibSum targetSum in
    do
      putStr "Input:"
      putStrLn $ "$N = "   ++ (show targetSum)
      putStrLn $ "possible ways are: "
      mapM_ ((\combiStr ->
                putStrLn( combiStr ++ " = " ++ (show targetSum)))
              .(intercalate " + ".map show)) allCombi

      putStrLn $ "Total " ++ (show (length allCombi)) ++ " case(s) found"
