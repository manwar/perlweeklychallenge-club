module Challenge219
  where
import Data.List ( sort )

solution :: [Int] -> [Int]
solution = sort . map (^ 2)
