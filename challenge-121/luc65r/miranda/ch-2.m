#!/usr/bin/env -S mira -exec

matrix == [[num]]

main = lay ( "matrix:":(map show mat)
            ++ [ ""
               , "tour: " ++ show besttour
               , "length: " ++ show (length mat besttour)
               ]
           )
       where
       arg = $* ! 1
       mat = (mkrandmat . numval) arg, if (and . map digit) arg
           = readmat arg,              otherwise
       tour t = t ++ [t ! 0]
       besttour = (minby (length mat) . map tour . perms) [0 .. #mat - 1]

length :: matrix -> [num] -> num
length mat tour = (sum . map get . zip2 tour . tl) tour
                  where
                  get (i,j) = mat ! j ! i

mkrandmat :: num -> matrix
mkrandmat n = [ [ f i j (rand ! (i * n + j)) | i <- [1..n] ] | j <- [1..n] ]
              where
              rand = (map ((+) 1 . (mod 9) . code) . readb) "/dev/random"
              f i j = const 0, if i == j
                    = id,      otherwise

readmat :: [char] -> matrix
readmat = map (map numval . words) . lines . read

words :: [char] -> [[char]]
words []     = []
words (x:xs) = []:words xs, if x = ' '
             = (x:y):ys,    otherwise
               where
               (y:ys) = words xs, if xs ~= []
                      = []:[],    otherwise

perms :: [*] -> [[*]]
perms [] = [[]]
perms x  = [ a:y | a <- x; y <- perms (x -- [a]) ]

minby :: (* -> num) -> [*] -> *
minby f (x:xs) = g x (f x) xs
                 where
                 g v mv []     = v
                 g v mv (x:xs) = g x mx xs, if mx < mv
                               = g v mv xs, otherwise
                                 where
                                 mx = f x
