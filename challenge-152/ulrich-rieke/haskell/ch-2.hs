module Challenge152_2
  where
import qualified Data.Set as S
import Data.List.Split( splitOn )
import Data.List ( (!!) )

computeArea :: (Int , Int) -> (Int , Int) -> Int
computeArea lowerLeft upperRight = ( fst upperRight - fst lowerLeft ) *
( snd upperRight - snd lowerLeft )

solution :: (Int , Int) -> (Int , Int) -> (Int , Int) -> (Int , Int) -> Int
solution firstLowerLeft firstUpperRight secondLowerLeft secondUpperRight =
computeArea firstLowerLeft firstUpperRight + computeArea secondLowerLeft
secondUpperRight - commonArea
where
  commonX :: [Int]
  commonX = S.toList $ S.fromList (enumFromTo (fst firstLowerLeft)
    (fst firstUpperRight)) `S.intersection` S.fromList ( enumFromTo
    (fst secondLowerLeft) (fst secondUpperRight) )
  commonY :: [Int]
  commonY = S.toList $ S.fromList (enumFromTo (snd firstLowerLeft)
    (snd firstUpperRight)) `S.intersection` S.fromList ( enumFromTo
    (snd secondLowerLeft) (snd secondUpperRight) )
  commonArea :: Int
  commonArea = ( maximum commonX - minimum commonX ) * ( maximum commonY -
    minimum commonY )

main :: IO ( )
main = do
  putStrLn "Please enter lower left and upper right point of first rectangle!"
  putStrLn "Enter integers separated by spaces!"
  rect1 <- getLine
  putStrLn "Please enter lower left and upper right point of second rectangle!"
  putStrLn "Enter integers separated by spaces!"
  rect2 <- getLine
  let rect1Nums = fmap read $ splitOn " " rect1
      rect2Nums = fmap read $ splitOn " " rect2
  putStrLn $ show $ solution ( rect1Nums !! 0 , rect1Nums !! 1 ) ( rect1Nums !! 2 ,
    rect1Nums !! 3 ) ( rect2Nums !! 0 , rect2Nums !! 1 ) ( rect2Nums !! 2 ,
    rect2Nums !! 3 )
