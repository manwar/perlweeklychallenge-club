# Weekly Challenge #250

### Task 1: Smallest Index
**Submitted by: Mohammad S Anwar**

You are given an array of integers, @ints.<br>
Write a script to find the smallest index i such that i mod 10 == $ints[i] otherwise return -1.

##### Example 1
```
Input: @ints = (0, 1, 2)
Output: 0

i=0: 0 mod 10 = 0 == $ints[0].
i=1: 1 mod 10 = 1 == $ints[1].
i=2: 2 mod 10 = 2 == $ints[2].

All indices have i mod 10 == $ints[i], so we return the smallest index 0.
```

##### Example 2
```
Input: @ints = (4, 3, 2, 1)
Output: 2

i=0: 0 mod 10 = 0 != $ints[0].
i=1: 1 mod 10 = 1 != $ints[1].
i=2: 2 mod 10 = 2 == $ints[2].
i=3: 3 mod 10 = 3 != $ints[3].

2 is the only index which has i mod 10 == $ints[i].
```

##### Example 3
```
Input: @ints = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
Output: -1

Explanation: No index satisfies i mod 10 == $ints[i].
```
---

### Solution

0 mod 10, 1 mod 10, 2 mod 10...* produces the repeating sequence 0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2...*

That sequence can be created as follows:

__flat(^10 xx *)__
- **^10** produces the list (0,1,2,3,4,5,6,7,8,9)
- __xx *__ repeats that list indefinitely
- **flat** flattens that list

Note that __(^10 xx *)__ is a lazy list so it will only produce as many elements as needed.

We can use the [zip operator](https://docs.raku.org/language/operators#infix_Z) to iterate over __@ints__ and __flat(^10 xx *)__ until we find the first match.

If **@ints** is (6 4 4 2 0 7 9 8 9 6 4 6 1 4 9 3 5 2 2 1 3 8 5 3 1 3 6 0 1 7)

__@ints Z flat(^10 xx *)__ will produce

((6 0) (4 1) (4 2) (2 3) (0 4) (7 5) (9 6) (8 7) (9 8) (6 9) (4 0) (6 1) (1 2) (4 3) (9 4) (3 5) (5 6) (2 7) (2 8) (1 9) (3 0) (8 1) (5 2) (3 3) (1 4) (3 5) (6 6) (0 7) (1 8) (7 9))

We have the sub-lists and we could go through those and find the first one with equal elements but there's a better way.
Instead of **Z** we'll use the [zip metaoperator](https://docs.raku.org/language/operators#Zip_metaoperator) **Z==** which will test each sub-list for equality as it zips the 2 lists.

__@ints Z== flat(^10 xx *)__ will produce

(False False False False False False False False False False False False False False False False False False False False False False False True False False True False False False)

From that list we want the **index** of the first **True** value. If we use **first({ $_ })** that would just return **True** but that's easy to fix with the **:k** parameter.

**first({ $_ }, :k)** will return the index of the first **True** value and the zipping will be short-circuited.

Finally, we add the [defined-or operator](https://docs.raku.org/language/operators#infix_//) and return -1 if a match isn't found.

Putting it all together:

    (@ints Z== flat(^10 xx *)).first({ $_ }, :k) // -1

[The full program](https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-250/mark-anderson/raku/ch-1.raku)

Thank you for reading my solution to the [Weekly Challenge #250 Task #1](https://theweeklychallenge.org/blog/perl-weekly-challenge-250/)

*-Mark Anderson*
