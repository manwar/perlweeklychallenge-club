Perl Weekly Challenge #271 - Challenge 2 - Haskell Version

> import Data.List ( sort )

You are give an array of integers, @ints.

Write a script to sort the integers in ascending order by the number of 1 bits in their binary representation. In case more than one integers have the same number of 1 bits then sort them in ascending order.

Example 1
Input: @ints = (0, 1, 2, 3, 4, 5, 6, 7, 8)
Output: (0, 1, 2, 4, 8, 3, 5, 6, 7)

0 = 0 one bits
1 = 1 one bits
2 = 1 one bits
4 = 1 one bits
8 = 1 one bits
3 = 2 one bits
5 = 2 one bits
6 = 2 one bits
7 = 3 one bits
Example 2
Input: @ints = (1024, 512, 256, 128, 64)
Output: (64, 128, 256, 512, 1024)

All integers in the given array have one 1-bits, so just sort them in ascending order.

Lets start with our test data again

> test_cases = [
>   [0, 1, 2, 3, 4, 5, 6, 7, 8],
>   [1024, 512, 256, 128, 64]
>  ]

The one thing I need is a function to convert an integer into a, ... let's say a list of bits

> int2bits :: (Integral a) => a -> [a]
> int2bits 0 = [0]
> int2bits n = mod n 2 : int2bits (div n 2)

That should be clear. We take an integer. If it is 0 we return [0]
Otherwise, recursion!
For a number n, mod n 2 will give us 0 if is even ie, the lowest bit is zero,
or 1 if it is odd, ie, the lowest bit is 1.
`div n 2` is effectively a right bitshift
so `mod n 2 : int2bits (div n 2)` gives the bit value of the lowest bit appended to the list
recursively generated on the right shifted value.
Note this gives us a little-endian array. For the current problem it is completely irrelevant
since we only care about the sum of the bits, and addition is commutative.

The rest should wrap up easily

> binary_sum_sort :: (Integral a) => [a] -> [a]
> binary_sum_sort mat =
>   let bit_sums = map (sum . int2bits) mat
>       indexed_list = zip bit_sums mat
>   in map snd $ sort indexed_list

Hmm... Actually that's pretty ugly. And it took me a while to get right
Let's break it down:
let l = [0, 1, 2]
`map (sum . int2bits) l` is going to apply the composition of sum and int2bits
  to each element of l. Let's break this down as if it were `map sum (map int2bits l)`
[we could have written it that way]



Then map it onto our test cases, for testing

> test_results = map binary_sum_sort test_cases
> main = putStrLn $ show test_results


