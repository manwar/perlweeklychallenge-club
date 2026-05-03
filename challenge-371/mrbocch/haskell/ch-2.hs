import Data.Function

--subsetEquilibrium :: [Int] -> [[Int]]
subsetEquilibrium nums = zip (repeat numIndx) (enumerations $ 2^(length nums) -1)
                       & map (\(l,mask) -> keeper l mask)
                       & filter (\x -> (sum (map snd x)) == (sum (map fst x)))
                       & map (\x -> (map fst) x)
                       & filter (\x -> length x > 1)
    where
        numIndx = zip nums [1..]

        keeper :: [a] -> [Bool] -> [a]
        keeper xs keeps = zip xs keeps
                        & filter (id snd)
                        & map fst

enumerations :: Int -> [[Bool]]
enumerations n = map intToBinS [1..n-1]
              & padZeroes
              & map (\xs -> map (\x -> if x == '1' then True else False) xs)
    where
        intToBinS n = intToBinS' n ""
            where
                intToBinS' :: Int -> String -> String
                intToBinS' n carry
                    | n == 0    = ('0':carry)
                    | n == 1    = ('1':carry)
                    | even n    = intToBinS' (quot n 2) ('0':carry)
                    | otherwise = intToBinS' (quot n 2) ('1':carry)
        padZeroes :: [String] -> [String]
        padZeroes xs = map (padZeroes' longestS) xs
            where
                padZeroes' longest x
                    | length x < longest = (take (longest - length x) (repeat '0')) ++ x
                    | otherwise          = x

                longestS = map length xs
                         & maximum

main :: IO ()
main = do
    let ex1 = subsetEquilibrium [2,1,4,3]
    let ex2 = subsetEquilibrium [3,0,3,0]
    let ex3 = subsetEquilibrium [5,1,1,1]
    let ex4 = subsetEquilibrium [3,-1,4,2]
    let ex5 = subsetEquilibrium [10,20,30,40]

    print $ elem [2,1] ex1 && elem [1,4] ex1 && elem [4,3] ex1 && elem [2,3] ex1 && length ex1 == 4
    print $ elem [3,0] ex2 && elem [3,0,3] ex2 && length ex2 == 2
    print $ elem [5,1,1] ex3 && length ex3 == 1
    print $ elem [3,2] ex4 && elem [3,-1,4] ex4 && length ex4 == 2
    print $ length ex5 == 0
