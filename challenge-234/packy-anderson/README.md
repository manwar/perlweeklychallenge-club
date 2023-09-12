# Solutions by Packy Anderson

## Perl

* [Task 1](perl/ch-1.pl)

Sample output
```
$ perl/ch-1.pl
Example 1:
Input: @words = ("java", "javascript", "julia")
Output: ("j", "a")

Example 2:
Input: @words = ("bella", "label", "roller")
Output: ("e", "l", "l")

Example 3:
Input: @words = ("cool", "lock", "cook")
Output: ("c", "o")
```

* [Task 2](perl/ch-2.pl)

Sample output
```
$ perl/ch-2.pl
Example 1:
Input: @ints = (4, 4, 2, 4, 3)
Output: 3

(0, 2, 4) because 4 != 2 != 3
(1, 2, 4) because 4 != 2 != 3
(2, 3, 4) because 2 != 4 != 3

Example 2:
Input: @ints = (1, 1, 1, 1, 1)
Output: 0

Example 3:
Input: @ints = (4, 7, 1, 10, 7, 4, 1, 1)
Output: 28

(0, 1, 2) because 4 != 7 != 1
(0, 1, 3) because 4 != 7 != 10
(0, 1, 6) because 4 != 7 != 1
(0, 1, 7) because 4 != 7 != 1
(0, 2, 3) because 4 != 1 != 10
(0, 2, 4) because 4 != 1 != 7
(0, 3, 4) because 4 != 10 != 7
(0, 3, 6) because 4 != 10 != 1
(0, 3, 7) because 4 != 10 != 1
(0, 4, 6) because 4 != 7 != 1
(0, 4, 7) because 4 != 7 != 1
(1, 2, 3) because 7 != 1 != 10
(1, 2, 5) because 7 != 1 != 4
(1, 3, 5) because 7 != 10 != 4
(1, 3, 6) because 7 != 10 != 1
(1, 3, 7) because 7 != 10 != 1
(1, 5, 6) because 7 != 4 != 1
(1, 5, 7) because 7 != 4 != 1
(2, 3, 4) because 1 != 10 != 7
(2, 3, 5) because 1 != 10 != 4
(2, 4, 5) because 1 != 7 != 4
(3, 4, 5) because 10 != 7 != 4
(3, 4, 6) because 10 != 7 != 1
(3, 4, 7) because 10 != 7 != 1
(3, 5, 6) because 10 != 4 != 1
(3, 5, 7) because 10 != 4 != 1
(4, 5, 6) because 7 != 4 != 1
(4, 5, 7) because 7 != 4 != 1
```

## Raku

* [Task 1](raku/ch-1.raku)

Sample output
```
$ raku/ch-1.raku
Example 1:
Input: @words = ("java", "javascript", "julia")
Output: ("j", "a")

Example 2:
Input: @words = ("bella", "label", "roller")
Output: ("e", "l", "l")

Example 3:
Input: @words = ("cool", "lock", "cook")
Output: ("c", "o")
```

* [Task 2](raku/ch-2.raku)

Sample output
```
```

## Guest Language: Python
* [Task 1](python/ch-1.py)
* [Task 2](python/ch-1.py)

## Blog Post

[Perl Weekly Challenge: Common, but Unequal, Triplet Characters](https://packy.dardan.com/2023/09/11/perl-weekly-challenge-common-but-unequal-triplet-characters/)