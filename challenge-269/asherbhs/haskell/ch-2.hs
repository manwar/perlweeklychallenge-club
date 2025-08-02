import Data.List (foldl')

distributeElements :: [Int] -> [Int]
distributeElements (a : b : xs) =
  let
    (ys, zs) = foldl'
        (\(y : ys, z : zs) x ->
            if y > z
            then (x : y : ys,     z : zs)
            else (    y : ys, x : z : zs)
        )
        ([a], [b])
        xs
  in
    reverse ys ++ reverse zs

main :: IO ()
main = do
    print $ distributeElements [2, 1, 3, 4, 5]
    print $ distributeElements [3, 2, 4]
    print $ distributeElements [5, 4, 3 ,8]
