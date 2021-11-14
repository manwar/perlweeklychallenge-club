module Challenge130_2
  where
import Data.Tree

myTreeA :: Tree Int
myTreeA = ( Node 8 [ Node 5 [ Node 4 [] , Node 6 []] , Node 9 []] )

myTreeB :: Tree Int
myTreeB = ( Node 5 [ Node 4 [ Node 3 [] , Node 6 []] , Node 7 []] )

isBST :: Tree Int -> Bool
isBST atree = ((maximum $ flatten $ head $ subForest atree) < ( rootLabel atree ))
&& (( minimum $ flatten $ last $ subForest atree ) > ( rootLabel atree ) )

solution :: Tree Int -> Int
solution atree = if isBST atree then 1 else 0
