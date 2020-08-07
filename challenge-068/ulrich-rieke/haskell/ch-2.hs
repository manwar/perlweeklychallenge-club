module Challenge068_2
  where

reorder :: [ a  ] -> [ a ]
reorder list =
  let len = length list
      half = len `div` 2
      firsthalf = take half list
      secondhalf = drop half list
      zipped = zip firsthalf $ reverse secondhalf
  in concat $ map myFunc zipped
      where
    myFunc :: (a , a ) -> [a]
    myFunc (c , d) = [c, d]
