import System.Environment
import System.Exit
import Data.Maybe (catMaybes)
import Data.List  (intersect, intercalate)

{- test with:
runhaskell ch-2.hs XXY XXZ XXXXZY
-}

data WhichPart = Odd | Even deriving (Show, Eq)

decomposeAsEachOddsEvensWith :: String -> [Int] -> ([String], String, String)
decomposeAsEachOddsEvensWith origStr splitRules =
-- note: this is unsafe method
  decompose [] "" "" origStr splitRules Odd
  where
    decompose ls os es  _    []    _ = (ls, os, es)
    decompose ls os es str (p:ps) wp =
      case wp of
        Odd  -> decompose ls' os' es  str' ps Even
        Even -> decompose ls' os  es' str' ps Odd
      where
        cs   = take p str;  str' = drop p str
        os'  = (os ++ cs);  es'  = (es ++ cs); ls'  = (ls ++ [cs])

-- entry point
allInterleavedCases :: String -> String -> String
  -> Either String [([String], String, String)]
allInterleavedCases sa sb sc
  | (length sa) + (length sb) /= targetSum
                = Left "length of strings are not matched."
  | null confirmedCases = Left "not interleaved"
  | otherwise = Right confirmedCases

  where
      targetSum = length sc
      confirmedCases =
        catMaybes $ maybe [] (map (\ils ->
                                     if (length ils) == 1 then Nothing
                                     else checkCaseFully ils ) ) possilbeCases

      possilbeCases = sps 1 targetSum maybeOk [] []

      checkCaseFully :: [Int] -> Maybe ([String], String, String)
      checkCaseFully ps =
        let (cs, o, e) = sc `decomposeAsEachOddsEvensWith` ps
        in
          if (sa == o && sb == e)
             || (sb == o && sa == e) then Just (cs, o, e)
          else
            Nothing

      maybeOk :: [Int] -> Bool
      maybeOk rule
        |  length rule <= 1 = True -- skip as okay, note: we have to sieve later
        |  otherwise =

             let (cs, a, b) = sc `decomposeAsEachOddsEvensWith` rule
             in
               any (\(sa', sb') ->
                        any ((intersect a sa')==) [a,sa']
                     && any ((intersect b sb')==) [b,sb']) [(sa,sb),(sb,sa)]

-- sps: some possible sum (permutations with repeatition with filter)
sps :: Int -> Int -> {-filter <= -}([Int] -> Bool)
  -> [Int] -> [[Int]] -> Maybe [[Int]]
sps cn origSum isValid parts siblings
  | origSum == 0 = Just []
  | (not.isValid) testParts = if null siblings then Nothing else Just siblings
  | cn == origSum =
      -- reach the max case in current depth: no  more next cases
      -- put siblings and this one together
      Just (siblings ++ [[cn]])
  | otherwise = -- try next cases with saving current cases if any
      sps nextNumber origSum isValid parts us

  where
    parts'     = parts ++ [cn]
    testParts  = parts'
    restSum    = origSum - cn
    nextNumber = succ cn
    us         = case currentCases of
                   Nothing    -> siblings
                   Just cases -> siblings ++ cases

    currentCases = fmap (map (cn:)) lowerCases
    lowerCases   = sps 1 restSum isValid parts' []

main = do
  args <- getArgs;
  let sa = args !! 0; sb = args !! 1; sc = args !! 2 in
    if  length args /= 3
    then die "Usage: runhaskell ch-2.hs <string A> <string B> <string C>"
    else
      case allInterleavedCases sa sb sc of
        Left err -> putStrLn $ "0 as " ++ err
        Right cases -> do
          putStrLn $ "1 as we found " ++ ((show.length) cases)
            ++ " possible cases found.\n"
            ++ "in other words, \"" ++ sc ++ "\" can be decomposed as below"
          mapM_ (\(cs, a, b) -> do
                    putStrLn $ "[" ++
                      ((intercalate ", ".map (\s -> "\""++ s ++"\"")) cs) ++ "]"
                      ++ " --> " ++ a ++ ", " ++ b
                    ) cases
