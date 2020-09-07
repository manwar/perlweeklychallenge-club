{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
import Options.Generic
import OthersPrimeNumber
import Data.List (sortBy, unfoldr)
import Data.Maybe (fromJust, isJust)

-- solution: same as 075/ch-1, so I made a little bit more general solution
minPrimeSum = (minimum.map length.allPrimeSum)
allPrimeSum s = allPossibleSum ( s, primeNumbers ) where
  primeNumbers = takeWhile (<=s) $ primesTME

allPossibleSum ( targetSum, els ) =
  case ( combPS targetSum els ) of
    Nothing -> []
    Just xs -> xs
  where
    combPS :: Int -> [Int] -> Maybe [[Int]]
    combPS targetSum els
      | null els  = Nothing
      | otherwise = Just $ (joinCombi.grepCombi) goThroughThisOne
      where
        this       = head sortedDesc
        others     = tail sortedDesc
        sortedDesc = sortBy(\a b -> compare b a) els
        maxNoe     = targetSum `div` this -- Noe: Number of Elements
        joinCombi  = foldr (++) []
        grepCombi  = (map fromJust).(filter isJust)

        goThroughThisOne = unfoldr goThroughThisOneInner maxNoe
        goThroughThisOneInner noe
          | noe < 0 = Nothing
          | True =
            if remainder == 0 then -- generate from maxNoe to 0
              Just ( Just [fillThisOne], (pred noe) )
            else case (combPS remainder others) of
                Nothing -> Just ( Nothing, (pred noe) )
                Just  p -> Just ( Just (
                                   map (\r -> fillThisOne ++ r) p), (pred noe))
          where
            fillThisOne = (replicate noe this)
            remainder   = targetSum - ( this * noe )

-- testing
main = do
  args <- getRecord "Challennge #076 - Task #1"
  let tSum = args :: Int in
    do
      putStrLn "Input:"
      putStrLn $ "$N = "   ++ (show tSum)
      putStrLn $ "possible ways are: "
      mapM_ (putStrLn.show)
        $ sortBy (\a b -> compare (length b) (length a)) (allPrimeSum tSum)

      putStrLn $ "Output:" ++ (show (minPrimeSum tSum))
