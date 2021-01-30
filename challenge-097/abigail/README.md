# Solution by Abigail
## [Ceasar Cipher](https://perlweeklychallenge.org/blog/perl-weekly-challenge-097/#TASK1)

You are given string `$S` containing alphabets `A..Z` only and a number `$N`.

Write a script to encrypt the given string `$S` using Caesar Cipher with
left shift of size `$N`.

### Example
~~~~
Input: $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", $N = 3
Output: "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD"

Plain:    ABCDEFGHIJKLMNOPQRSTUVWXYZ
Cipher:   XYZABCDEFGHIJKLMNOPQRSTUVW

Plaintext:  THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
Ciphertext: QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD
~~~~

### Note
We will be reading the plain text from STDIN, and use an option (-s)
to indicate the left shift.

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [Lua](lua/ch-1.lua)
* [C](c/ch-1.c)
* [Node.js](node/ch-1.js)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)
* [Ruby](ruby/ch-1.rb)

### Blog
[Perl Weekly Challenge 97: Ceasar Cipher](https://wp.me/pcxd30-nW)


## [Binary Substrings](https://perlweeklychallenge.org/blog/perl-weekly-challenge-097/#TASK2)

You are given a binary string `$B` and an integer `$S`.

Write a script to split the binary string `$B` of size `$S` and then
find the minimum number of flips required to make it all the same.

### Examples
#### Example 1
~~~~
Input: $B = "101100101" $S = 3
Output: 1

Binary Substrings:
    "101": 0 flip
    "100": 1 flip to make it "101"
    "101": 0 flip
~~~~

#### Example 2
~~~~
Input $B = "10110111", $S = 4
Output: 2

Binary Substrings:
    "1011": 0 flip
    "0111": 2 flips to make it "1011"
~~~~

### Notes
We will be reading the strings from STDIN. The length of each sub string
will be passed in as an option: -s SIZE.

To calculate the mininim number of flips required, note that we
can calculate the number of flips for each position independently;
that is, flipping a bit at position $i doesn't influence how the
number of flips required for position $j, if $i != $j.

For each position $i, we either need to flip all the 0s to 1s,
or all the 1s to 0s. To minimize the number of flips, we count
the number of 0s in each position, and compare that with the
number of 1s in that position. Then we take the minimum of 0s
and 1s, and sum this for all positions.

There is no need to split the input string into chunks,
we can leave it as is. The $i-th character of the $j-th section
is as position $j * $s_len + $i, where $s_len is the length
of a section.

### Solutions
* [AWK](awk/ch-2.awk)
* [Bash](bash/ch-2.sh)
* [C](c/ch-2.c)
* [Lua](lua/ch-2.lua)
* [Node](node/ch-2.js)
* [Perl](perl/ch-2.pl)
* [Python](python/ch-2.py)
* [Ruby](ruby/ch-2.rb)

### Blog
[Perl Weekly Challenge 97: Binary Substrings](https://wp.me/pcxd30-pi)
