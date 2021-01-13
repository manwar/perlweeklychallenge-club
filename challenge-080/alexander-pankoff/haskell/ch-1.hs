import System.Environment (getArgs)
import Data.List (find)
import qualified Data.Set as Set

type IntegerSet = Set.Set Integer

main :: IO ()
main = do
  inputSet <- Set.fromList <$> (readInteger <<$>> getArgs)
  let maybeMissing = smallestMissingPositiveNumber inputSet
  maybe
    (fail "no smallest missing number found.")
    print
    maybeMissing
  where
   readInteger :: String -> Integer
   readInteger = read

smallestMissingPositiveNumber :: IntegerSet -> Maybe Integer
smallestMissingPositiveNumber set = find (not . inSet) [1..]
 where
  inSet = (`Set.member` set)

infixl 4 <<$>>

(<<$>>) :: (Functor f, Functor g) => (a -> b) -> f (g a) -> f (g b)
(<<$>>) = fmap . fmap
