# Solution by Abigail
## [Pattern Match](https://perlweeklychallenge.org/blog/perl-weekly-challenge-099/#TASK1)

You are given a string `$S` and a pattern `$P`.

Write a script to check if given pattern validate the entire string.
Print `1` if pass otherwise `0`.

The patterns can also have the following characters:
* ? - Match any single character.
* * - Match any sequence of characters.

### Examples
#### Example 1
~~~~
Input: $S = "abcde" $P = "a*e"
Output: 1
~~~~


#### Example 2
~~~~
Input: $S = "abcde" $P = "a*d"
Output: 0
~~~~


#### Example 3
~~~~
Input: $S = "abcde" $P = "?b*d"
Output: 0
~~~~


#### Example 4
~~~~
Input: $S = "abcde" $P = "a*c?e"
Output: 1
~~~~


## [Unique Subsequence](https://perlweeklychallenge.org/blog/perl-weekly-challenge-099/#TASK2)

You are given two strings `$S` and `$T`.

Write a script to find out count of different unique subsequences
matching `$T` without changing the position of characters.

### Examples
#### Example 1
~~~~
Input: $S = "littleit', $T = 'lit'
Output: 4

    1: [lit] tleit
    2: [li] t [t] leit
    3: [li] ttlei [t]
    4: litt [l] e [it]
~~~~

#### Example 2
~~~~
Input: $S = "london', $T = 'lon'
Output: 3

    1: [lon] don
    2: [lo] ndo [n]
    3: [l] ond [on]
~~~~
