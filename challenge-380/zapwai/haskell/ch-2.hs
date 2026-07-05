import Data.Char (ord)
rev_ind c = 26 - (ord c - ord 'a')
main = do
  let cases = ["z", "a", "bbc", "racecar", "zyx"]
  mapM_ handle cases
    where
      handle s = do
        putStrLn ("Input: " ++ show s)
        let tot = sum [ i * rev_ind c | (i, c) <- zip [1..] s ]
        putStrLn ("Output: " ++ show tot)
