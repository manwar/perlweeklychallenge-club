# Solutions by Packy Anderson

## Perl

* [Task 1](perl/ch-1.pl)

Sample output
```
$ perl/ch-1.pl
Example 1:
Input: @words = ("aba", "aabb", "abcd", "bac", "aabc")
Output: 2

Pair 1: similar words ("bac", "aabc")
Pair 2: similar words ("aba", "aabb")

Example 2:
Input: @words = ("aabb", "ab", "ba")
Output: 3

Pair 1: similar words ("aabb", "ab")
Pair 2: similar words ("aabb", "ba")
Pair 3: similar words ("ab", "ba")

Example 3:
Input: @words = ("nba", "cba", "dba")
Output: 0
```

* [Task 2](perl/ch-2.pl)

Sample output
```
$ perl/ch-2.pl
Example 1:
Input: @ints = (1, 1, 2, 2, 2, 3)
Output: (3, 1, 1, 2, 2, 2)

'3' has a frequency of 1
'1' has a frequency of 2
'2' has a frequency of 3


Example 2:
Input: @ints = (2, 3, 1, 3, 2)
Output: (1, 3, 3, 2, 2)

'1' has a frequency of 1
'2' and '3' both have a frequency of 2, so they are sorted in decreasing order


Example 3:
Input: @ints = (-1, 1, -6, 4, 5, -6, 1, 4, 1)
Output: (5, -1, 4, 4, -6, -6, 1, 1, 1)

'-1' and '5' both have a frequency of 1, so they are sorted in decreasing order
'-6' and '4' both have a frequency of 2, so they are sorted in decreasing order
'1' has a frequency of 3
```

## Raku

* [Task 1](raku/ch-1.raku)

Sample output
```
$ raku/ch-1.raku
Example 1:
Input: @words = ("aba", "aabb", "abcd", "bac", "aabc")
Output: 2

Pair 1: similar words ("bac", "aabc")
Pair 2: similar words ("aba", "aabb")

Example 2:
Input: @words = ("aabb", "ab", "ba")
Output: 3

Pair 1: similar words ("aabb", "ab")
Pair 2: similar words ("aabb", "ba")
Pair 3: similar words ("ab", "ba")

Example 3:
Input: @words = ("nba", "cba", "dba")
Output: 0
```

* [Task 2](raku/ch-2.raku)

Sample output
```
$ raku/ch-2.raku
Example 1:
Input: @ints = (1, 1, 2, 2, 2, 3)
Output: (3, 1 1, 2 2 2)

'3' has a frequency of 1
'1' has a frequency of 2
'2' has a frequency of 3


Example 2:
Input: @ints = (2, 3, 1, 3, 2)
Output: (1, 3 3, 2 2)

'1' has a frequency of 1
'2' and '3' both have a frequency of 2, so they are sorted in decreasing order


Example 3:
Input: @ints = (-1, 1, -6, 4, 5, -6, 1, 4, 1)
Output: (5, -1, 4 4, -6 -6, 1 1 1)

'-1' and '5' both have a frequency of 1, so they are sorted in decreasing order
'-6' and '4' both have a frequency of 2, so they are sorted in decreasing order
'1' has a frequency of 3
```

## Guest Language: Python
* [Task 1](python/ch-1.py)
* [Task 2](python/ch-1.py)

## Blog Post

[Perl Weekly Challenge: What's the Frequency, Kenneth?](https://packy.dardan.com/2023/09/05/perl-weekly-challenge-whats-the-frequency-kenneth/)