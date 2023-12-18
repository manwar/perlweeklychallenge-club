# Solutions by Packy Anderson

## Raku

* [Task 1](raku/ch-1.raku)

Sample output
```
$ raku/ch-1.raku
Example 1:
Input: @names = ('Mr. Wall',
                 'Mrs. Wall',
                 'Mr. Anwar',
                 'Mrs. Anwar',
                 'Mr. Conway',
                 'Mr. Cross')
Output:
    Mr. Wall -> Mr. Cross
    Mrs. Wall -> Mr. Conway
    Mr. Anwar -> Mr. Wall
    Mrs. Anwar -> Mrs. Wall
    Mr. Conway -> Mrs. Anwar
    Mr. Cross -> Mr. Anwar

Example 2:
Input: @names = ('Mr. Wall',
                 'Mrs. Wall',
                 'Mr. Anwar')
Output:
    Mr. Wall -> Mr. Anwar
    Mrs. Wall -> Mr. Wall
    Mr. Anwar -> Mrs. Wall
```

* [Task 2](raku/ch-2.raku)

Sample output
```
$ raku/ch-2.raku
Example 1:
Input: $s = 'abcdbca'
Output: 'bc'

'bc' appears twice in $s

Example 2:
Input: $s = 'cdeabeabfcdfabgcd'
Output: 'ab'

'ab' and 'cd' appear three times in $s and 'ab' is lexicographically smallest.

Example 3:
Input: $s = 'abcdeabcde'
Output: 'ab'

'ab', 'bc', 'cd', and 'de' appear twice in $s and 'ab' is lexicographically smallest.
```

## Perl

* [Task 1](perl/ch-1.pl)

Sample output
```
$ perl/ch-1.pl
Example 1:
Input: @names = ('Mr. Wall',
                 'Mrs. Wall',
                 'Mr. Anwar',
                 'Mrs. Anwar',
                 'Mr. Conway',
                 'Mr. Cross')
Output:
    Mr. Wall -> Mrs. Anwar
    Mrs. Wall -> Mr. Cross
    Mr. Anwar -> Mr. Conway
    Mrs. Anwar -> Mr. Wall
    Mr. Conway -> Mr. Anwar
    Mr. Cross -> Mrs. Wall

Example 2:
Input: @names = ('Mr. Wall',
                 'Mrs. Wall',
                 'Mr. Anwar')
Output:
    Mr. Wall -> Mr. Anwar
    Mrs. Wall -> Mr. Wall
    Mr. Anwar -> Mrs. Wall
```

* [Task 2](perl/ch-2.pl)

Sample output
```
$ perl/ch-2.pl
Example 1:
Input: $s = 'abcdbca'
Output: 'bc'

'bc' appears twice in $s

Example 2:
Input: $s = 'cdeabeabfcdfabgcd'
Output: 'ab'

'ab' and 'cd' appear three times in $s and 'ab' is lexicographically smallest.

Example 3:
Input: $s = 'abcdeabcde'
Output: 'ab'

'ab', 'bc', 'cd', and 'de' appear twice in $s and 'ab' is lexicographically smallest.
```

## Guest Language: Python
* [Task 1](python/ch-1.py)
* [Task 2](python/ch-2.py)

## Blog Post

[Perl Weekly Challenge: Writing Letter Pairs to Santa](https://packy.dardan.com/b/FK)
