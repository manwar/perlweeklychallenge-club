import Control.Monad (liftM2)
import Data.List (group)
import Data.List.HT (allEqual, mapAdjacent)

zigZag = liftM2
          (flip (-))
          (fromEnum . allEqual)
          ((2 +) . maximum . (0 :) . map sum
                 . group
                 . map (fromEnum . (0 >))
                 . mapAdjacent (*)
                 . mapAdjacent (-))
