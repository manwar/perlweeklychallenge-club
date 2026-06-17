import Data.Char
import Data.Set (Set)
import qualified Data.Set as Set 

secondLargestDigit :: String -> Maybe Int 
secondLargestDigit = secondMax . map digitToInt . filter isDigit 
  where
    secondMax :: [Int] -> Maybe Int 
    secondMax = secondMax' . Set.fromList
      where
        secondMax' :: Set Int -> Maybe Int
        secondMax' s
          | Set.size s < 2 = Nothing
          | otherwise      = Just $ Set.findMax $ Set.deleteMax s 
    
main :: IO ()
main = do
  print $ secondLargestDigit "aaaaa77777"         == Nothing 
  print $ secondLargestDigit "abcde"              == Nothing 
  print $ secondLargestDigit "9zero8eight7seven9" == Just 8 
  print $ secondLargestDigit "xyz9876543210"      == Just 8 
  print $ secondLargestDigit "4abc4def2ghi8jkl2"  == Just 4 
