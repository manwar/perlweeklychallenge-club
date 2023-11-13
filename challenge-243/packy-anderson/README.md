# Solutions by Packy Anderson

## Raku

* [Task 1](raku/ch-1.raku)

Sample output
```
$ raku/ch-1.raku
Example 1:
Input: @arr1 = (1, 2, 3)
       @arr2 = (2, 4, 6)
Output: ([1, 3], [4, 6])

(1, 2, 3) has 2 members (1, 3) missing from the array (2, 4, 6)
(2, 4, 6) has 2 members (4, 6) missing from the array (1, 2, 3)
Example 2:
Input: @arr1 = (1, 2, 3, 3)
       @arr2 = (1, 1, 2, 2)
Output: ([3])

(1, 2, 3, 3) has 2 members (3, 3) missing from the array (1, 1, 2, 2)
(1, 1, 2, 2) has 0 members missing from the array (1, 2, 3, 3)
```

* [Task 2](raku/ch-2.raku)

Sample output
```
$ raku/ch-2.raku
Example 1:
Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])

Example 2:
Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])
```

## Perl

* [Task 1](perl/ch-1.pl)

Sample output
```
$ perl/ch-1.pl
Example 1:
Input: @arr1 = (1, 2, 3)
       @arr2 = (2, 4, 6)
Output: ([1, 3], [4, 6])

(1, 2, 3) has 2 members (1, 3) missing from the array (2, 4, 6)
(2, 4, 6) has 2 members (4, 6) missing from the array (1, 2, 3)
Example 2:
Input: @arr1 = (1, 2, 3, 3)
       @arr2 = (1, 1, 2, 2)
Output: ([3])

(1, 2, 3, 3) has 2 members (3, 3) missing from the array (1, 1, 2, 2)
(1, 1, 2, 2) has 0 members missing from the array (1, 2, 3, 3)
```

* [Task 2](perl/ch-2.pl)

Sample output
```
$ perl/ch-2.pl
Example 1:
Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])

Example 2:
Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])
```

## Guest Language: Python
* [Task 1](python/ch-1.py)
* [Task 2](python/ch-2.py)

## Blog Post

[Perl Weekly Challenge: Flip the Missing Matrix Members](https://packy.dardan.com/2023/11/05/perl-weekly-challenge-flip-the-missing-matrix-members/)
