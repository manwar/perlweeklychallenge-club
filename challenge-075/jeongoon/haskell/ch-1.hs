{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
import Options.Generic
import Data.List (sortBy, unfoldr)
import Data.Maybe (fromJust, isJust)

{- Tested with:
runhaskell ch-1.hs --coinsum=6 --c=1 --c=2 --c=4
-}

-- solution
totalNumberOfCombinations = length.combiCoinSum
combiCoinSum ( targetSum, coins ) =
  case ( combCS targetSum coins ) of
    Nothing -> []
    Just xs -> xs
  where
    combCS :: Int -> [Int] -> Maybe [[Int]]
    combCS targetSum coins
      | null coins = Nothing
      | otherwise  = Just $ (joinCombi.grepCombi) goThroughThisCoin
      where
        thisCoin        = head sortedCoinsDesc
        otherCoins      = tail sortedCoinsDesc
        sortedCoinsDesc = sortBy (\a b -> compare b a) coins
        maxNoc          = targetSum `div` thisCoin -- Noc : Number Of Coins
        joinCombi       = foldr (++) []
        grepCombi       = (map fromJust).(filter isJust)

        goThroughThisCoin = unfoldr goThroughThisCoinInner maxNoc
        goThroughThisCoinInner noc
          | noc < 0 = Nothing
          | otherwise =
            if smallChange == 0 then -- generate from nocMax to 0
              Just ( Just [fillThisCoin], (pred noc) )
            else case (combCS smallChange otherCoins) of
                Nothing -> Just ( Nothing, (pred noc) )
                Just  p -> Just ( Just (
                                   map (\r -> fillThisCoin ++ r) p), (pred noc))
          where
            fillThisCoin = (replicate noc thisCoin)
            smallChange  = targetSum - ( thisCoin * noc )

data Sample = Sample { coinsum :: Int, c :: [Int] }
  deriving (Generic, Show)
instance ParseRecord Sample

-- testing
main = do
  args <- getRecord "Challennge #076 - Task #1"
  let sample = args :: Sample
      sSum   = coinsum sample
      sCoins = c       sample in
    do
      putStrLn "Input:"
      putStrLn $ "@C = "   ++ (show sCoins)
      putStrLn $ "$S = "   ++ (show sSum)
      putStrLn $ "Output:" ++ (show (totalNumberOfCombinations(sSum, sCoins)))
      putStrLn $ "possible ways are: "
      mapM_ (putStrLn.show) (combiCoinSum(sSum, sCoins))
