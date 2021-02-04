# Solution by Abigail
## [Read N-characters](https://perlweeklychallenge.org/blog/perl-weekly-challenge-098/#TASK1)

You are given file `$FILE`.

Create subroutine `readN($FILE, $number)` returns the first `n`-characters
and moves the pointer to the (`n+1`)th character.

### Example
~~~~
Input: Suppose the file (input.txt) contains "1234567890"
Output:
    print readN("input.txt", 4); # returns "1234"
    print readN("input.txt", 4); # returns "5678"
    print readN("input.txt", 4); # returns "90"
~~~~

### Solutions

### Blog


## [Search Insert Position](https://perlweeklychallenge.org/blog/perl-weekly-challenge-098/#TASK2)

You are given a sorted array of distinct integers `@N` and a target `$N`.

Write a script to return the index of the given target if found
otherwise place the target in the sorted array and return the index.

### Examples
#### Example 1
~~~~
Input: @N = (1, 2, 3, 4) and $N = 3
Output: 2 since the target 3 is in the array at the index 2.
~~~~

#### Example 2
~~~~
Input: @N = (1, 3, 5, 7) and $N = 6
Output: 3 since the target 6 is missing and should be placed at the index 3.
~~~~

#### Example 3
~~~~
Input: @N = (12, 14, 16, 18) and $N = 10
Output: 0 since the target 10 is missing and should be placed at the index 0.
~~~~

#### Example 4
~~~~
Input: @N = (11, 13, 15, 17) and $N = 19
Output: 4 since the target 19 is missing and should be placed at the index 4.
~~~~

### Solutions

### Blog
