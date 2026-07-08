import Data.List (transpose, sort)

check_rows m =
  let n = length m
  in all (\row -> sort row == [1..n]) m

check_cols m = check_rows (transpose m)

main = do
  let input =
        [ [ [1, 2, 3, 4],
            [2, 3, 4, 1],
            [3, 4, 1, 2],
            [4, 1, 2, 3]
          ],
          [ [1]
          ],
          [ [1,2,5],
            [5,1,2],
            [2,5,1]
          ],
          [ [1, 2, 3],
            [1, 2, 3],
            [1, 2, 3]
          ],
          [ [1,2,3],
            [3,1,2],
            [3,2,1]
          ]
        ]

  mapM_ proc input
  where
    proc m = do
      putStrLn ("Input: " ++ show m)
      putStrLn ("Output: " ++ show (check_rows m && check_cols m))
    
