# Solution by Abigail
## [Read N-characters](https://perlweeklychallenge.org/blog/perl-weekly-challenge-098/#TASK1)

You are given file `$FILE`.

Create subroutine `readN($FILE, $number)` returns the first `n`-characters
and moves the pointer to the (`n+1`)th character.

### Notes

What a poorly defined challenge.

> You are given a file

What does that mean? Do we get the content? A file handle?
A file descriptor? A file name?

The example (but not the challenge itself), suggest we're getting
a file name. Ok, but....:

> moves the pointer

What pointer? File handles/descriptors point to something, so
then it can be argued we should leave the file handle open, 
pointing to a place in the file. But we have just established we
are *not getting* a file handle -- we're getting a file name.
So, what pointer are we talking about?

What on earth are we supposed to do?

Are we supposed to create a file handle, and keep file handle open?
Should we just slurp in the file content, and keep a pointer
to what we have returned?

What should happen if we call `readN` with different files, interleaved?
Keep track of where we are for each file? Restart if called with `file1`,
then `file2`, and then `file1` again?

Our implementation will be a real stab in the dark -- we've no idea what
we are supposed to do.

### Input
Our program will read lines from standard input; each line consists
of a filename and an amount of characters to read, separated by whitespace.

### Example
~~~~
Input: Suppose the file (input.txt) contains "1234567890"
Output:
    print readN("input.txt", 4); # returns "1234"
    print readN("input.txt", 4); # returns "5678"
    print readN("input.txt", 4); # returns "90"
~~~~

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [C](c/ch-1.ch)
* [Lua](lua/ch-1.lua)
* [Perl](perl/ch-1.pl)

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

### Notes
We could write a binary search to find the target number in the
array. This is tempting, as a binary search take O (log N). But
this is futile. We're also asked to add the target element to the
array (if not found), and adding an element in the middle of an
array takes linear time. So, worst case, we're already spending
linear time. (And to read the array, we're spending linear time
anyway).


### Solutions
* [Bash](bash/ch-2.sh)
* [Perl](perl/ch-2.pl)

### Blog
