import Control.Monad (<*>)

solution = flip (zipWith (div) . repeat)  <*> product

-- Tests
solution [5,2,1,4,3] -- [24,60,120,30,40]
solution [2,1,4,3]   -- [12,24,6,8]
