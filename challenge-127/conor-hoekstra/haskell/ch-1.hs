
-- Solution 1
import Data.List (intersect)
import Data.Composition (.:) -- blackbird

solution = null .: intersect

-- Solution 2
import Data.List.HT (outerProduct)
import Data.Composition (.:) -- blackbird

solution = and . (map not) . concat .: outerProduct (==)
