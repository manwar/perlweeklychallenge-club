Perl Weekly Challenge #271 - Challenge 1 - Haskell Version

************
Description:
You are given a m x n binary matrix.

Write a script to return the row number containing maximum ones, in case of more than one rows then return smallest row number.

Example 1
Input: $matrix = [ [0, 1],
                   [1, 0],
                 ]
Output: 1

Row 1 and Row 2 have the same number of ones, so return row 1.
Example 2
Input: $matrix = [ [0, 0, 0],
                   [1, 0, 1],
                 ]
Output: 2

Row 2 has the maximum ones, so return row 2.
Example 3
Input: $matrix = [ [0, 0],
                   [1, 1],
                   [0, 0],
                 ]
Output: 2

Row 2 have the maximum ones, so return row 2.
************

Seems easy enough. Let's try to create our test data first

> test_cases = [
>   [[0, 1], [1, 0]],
>   [[0, 0, 0], [1, 0, 1]],
>   [[0, 0], [1, 1], [0, 0]]]


I want numpy style argmax, which I just realized is more like indexmax ...

> indexMax :: (Ord a) => [a] -> Int
> indexMax [] = error "index maximum of empty list"
> indexMax l =
>   let max_l = maximum l
>       indexed_l = zip l [0..]
>   in snd ( [iv | iv <- indexed_l, (\ x -> fst x == max_l) iv] !! 0 )

With that in place, all we need is to:
 - sum each row giving us a 1-d list
 - find the indexMax on that list
 - add 1 because this is like 1 indexed, not 0 indexed

> maxRow :: (Num a, Ord a) => [[a]] -> Int
> maxRow l = (+) 1 $ indexMax $ map sum l

We can walk through this with a test case:
let l = [[0, 0, 0], [1, 0, 1]]
First we take `map sum l` -> [0, 2]
Then we take `indexMax [0, 2]` -> 1
Then, per the instructions, row 1 is the second row
so we add 1 `(+) 1 1` -> 2
Done.

Now map our function over our test cases

> row_sums = map maxRow test_cases

And print out the output.

> main = putStrLn $ show row_sums

