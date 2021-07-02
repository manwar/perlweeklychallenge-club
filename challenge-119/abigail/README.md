# Solutions by Abigail
## [Swap Nibbles](https://perlweeklychallenge.org/blog/perl-weekly-challenge-119/#TASK1)

> You are given a positive integer `$N`.
>
> Write a script to swap the two nibbles of the binary representation of
> the given number and print the decimal number of the new binary
> representation.
>
> > A nibble is a four-bit aggregation, or half an octet.
>
> To keep the task simple, we only allow integer less than or equal to `255`.

### Examples
~~~~
Input: $N = 101
Output: 86
~~~~

Binary representation of decimal `101` is `1100101` or as 2 nibbles
`(0110)(0101)`. The swapped nibbles would be `(0101)(0110)` same as
decimal `86`.

~~~~
Input: $N = 18
Output: 33
~~~~

Binary representation of decimal `18` is `10010` or as 2 nibbles
`(0001)(0010)`. The swapped nibbles would be `(0010)(0001)` same as
decimal `33`.

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [bc](bc/ch-1.bc)
* [C](c/ch-1.c)
* [Go](go/ch-1.go)
* [Java](java/ch-1.java)
* [Lua](lua/ch-1.lua)
* [Node.js](node/ch-1.js)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)
* [Ruby](ruby/ch-1.rb)

### Blog
[Swap Nibbles](https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-119-1.html)

## [Sequence without 1-on-1](https://perlweeklychallenge.org/blog/perl-weekly-challenge-119/#TASK2)

> Write a script to generate sequence starting at `1`. Consider the
> increasing sequence of integers which contain only `1`s, `2`s, and
> `3`s, and do not have any doublets of `1`s > like below. Please accept
> a positive integer `$N` and print the `$N`th term in the generated sequence.
>
> > 1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, ...

### Solutions
* [AWK](awk/ch-2.awk)
* [Bash](bash/ch-2.sh)
* [C](c/ch-2.c)
* [Lua](lua/ch-2.lua)
* [Node.js](node/ch-2.js)
* [Perl](perl/ch-2.pl)
* [Python](python/ch-2.py)
* [Ruby](ruby/ch-2.rb)

### Blog
[Sequence without 1-on-1](https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-119-2.html)
