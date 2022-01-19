module Challenge146_2
  where
import Data.List.Split ( splitOn )

createBrother :: (Int , Int ) -> ( Int , Int )
createBrother ( dividend , divisor )
  |maxi == dividend = (maxi - mini , maxi)
  |mini == dividend = ( maxi , maxi - mini )
  where
      maxi :: Int
      maxi = maximum [ dividend , divisor]
      mini :: Int
      mini = minimum [ dividend , divisor ]

createParent :: (Int , Int) -> (Int , Int) -> (Int , Int)
createParent ( dividend , divisor ) ( bdividend , bdivisor )
  |product > 1.0 = ( maximum [firstMin , secondMin] , minimum [firstMin , secondMin])
  |product < 1.0 = ( minimum [firstMin , secondMin] , maximum [firstMin , secondMin])
  |product == 1.0 = ( 1 , 1 )
  where
      product :: Double
      product = (fromIntegral dividend / fromIntegral divisor) * ( fromIntegral
        bdividend / fromIntegral bdivisor )
      firstMin :: Int
      firstMin = minimum [ dividend , divisor ]
      secondMin :: Int
      secondMin = minimum [bdividend , bdivisor]

solution :: String -> String
solution input
  |input == "1/2" = "parent = 1/1 and grandparent ="
  |input == "2/1" = "parent = 1/1 and grandparent ="
  |otherwise = "parent = " ++ (show $ fst parent) ++ "/" ++ ( show $ snd parent )
                ++ " and grandparent = " ++ ( show $ fst grandparent ) ++ "/" ++
        (show $ snd grandparent)
  where
      fracNumbers :: [Int]
      fracNumbers = map read $ splitOn "/" input
      brother :: (Int , Int)
      brother = createBrother ( head fracNumbers , last fracNumbers )
      parent :: (Int , Int )
      parent = createParent ( head fracNumbers , last fracNumbers ) ( fst brother ,
                snd brother )
      uncle :: (Int , Int)
      uncle = createBrother (fst parent , snd parent)
      grandparent :: ( Int , Int )
      grandparent = createParent (fst parent , snd parent) (fst uncle , snd uncle)
