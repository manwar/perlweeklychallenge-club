{-# LANGUAGE ScopedTypeVariables #-}

-- [The Weekly Challenge - 113](https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/),
-- TASK #1: Represent Integer

-- You are given a positive integer `n` and a digit `d`.

-- Write a script to check if `n` can be represented as a sum of
-- positive integers [all] having `d` at least once [in their decimal
-- representation]. If check passes print 1 otherwise 0.

-- Note: there is a [blog post about this](http://functional-perl.org/docs/blog/perl-weekly-challenges-113.xhtml).


module Main where
import qualified Data.Set as Set
import Data.Maybe
import Data.Either
import Test.HUnit
import qualified System.Environment as Environment
import qualified System.Exit as Exit
import qualified Text.Read as Read

-- I'm using parens instead of $ and `let` instead of `where` to make
-- the code look closer to the Perl version / more familiar to Perl
-- programmers.

-- Also, using this now pretty wide-spread (but not sure about
-- Haskell) piping operator to make the code look similar to OO code
-- using method calls.
(|>) :: t1 -> (t1 -> t2) -> t2
a |> b = b a

-- Unlike in the Perl version, I'm only implementing the algorithm
-- used in `maybe_choose_optim_2` here:

chooseOptim2 :: forall n. (Num n, Ord n) => n -> [n] -> Maybe [n]
chooseOptim2 ntop ns =
  let nsSet = Set.fromList ns
      check :: [n] -> Maybe [n]
      check chosen =
        let decide n =
              let chosen' = n:chosen
                  missing = ntop - (sum chosen')
              in
                if missing == 0 then
                  Just (Right chosen')
                else if missing < 0 then
                  Nothing
                else
                  if Set.member missing nsSet then
                    Just (Right (missing : chosen'))
                  else
                    Just (Left (check chosen'))
            decisions :: [Either (Maybe [n]) [n]]
            decisions = ns |> map decide |> takeWhile isJust |> catMaybes
            solutions :: [[n]]
            solutions = rights decisions
            recursions :: [Maybe [n]]
            recursions = lefts decisions
        in
          case solutions of
            (solution:_) -> Just solution
            _ ->
              case recursions |> catMaybes of
                (solution:_) -> Just solution
                _ -> Nothing
  in
    check []

validNumbers :: Integer -> Char -> [ Integer ]
validNumbers n d =
  filter (\i -> elem d (show i)) [1..n]

representable :: Integer -> Char -> Maybe [Integer]
representable n d =
  let ns = validNumbers n d
  in
    chooseOptim2 n (reverse ns)


----------------------------------------------------------------------

tests :: [Test]
tests = map (\(n,d,r) -> TestCase(
                assertEqual
                ("> representable " ++ (show n) ++ " '" ++ [d, '\''])
                r
                (representable n d)))
  [ (25, '7', Nothing)
  , (24, '7', Just [7, 17])
  , (200, '9', Just [9, 191])
  , (200, '8', Just [18, 182])
  , (200, '7', Just [27, 173])
  , (200, '6', Just [36, 164])
  , (20000, '8', Just [18, 19982])
  , (40000, '8', Just [18, 39982])
  , (40000, '6', Just [36, 39964])
  ]

runTests :: IO Counts
runTests = runTestTT (TestList tests)

usage :: String -> IO ()
usage prog  = putStrLn ("Usage: " ++ prog ++ " --test | N D")

usageMsg :: String -> String -> IO ()
usageMsg prog msg = do
  putStrLn ("Error: " ++ msg)
  usage prog

exit, die :: IO ()
exit    = Exit.exitWith Exit.ExitSuccess
die     = Exit.exitWith (Exit.ExitFailure 1)

main_ :: String -> [String] -> IO ()
main_ prog ["-h"]      = usage prog >> exit
main_ prog ["--help"]  = usage prog >> exit
main_ _pro ["--test"]  = runTests >> return ()
main_ prog [nstr, [d]] = do
  case Read.readEither nstr of
    Right n -> putStr $ show $ representable n d
    Left msg -> usageMsg prog msg
main_ prog _           = usage prog >> die

main :: IO ()
main = do
  args <- Environment.getArgs
  p <- Environment.getProgName
  main_ p args
  return ()

