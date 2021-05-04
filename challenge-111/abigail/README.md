# Solutions by Abigail
## [Search Matrix](https://perlweeklychallenge.org/blog/perl-weekly-challenge-111/#TASK1)

> You are given 5x5 matrix filled with integers such that each row is
> sorted from left to right and the first integer of each row is greater
> than the last integer of the previous row.
>
> Write a script to find a given integer in the matrix using an
> efficient search algorithm.

### Notes
This challenge confuses me. We're basically asked to find a number
in a sorted list. Which in languages without hashes one would solve
with binary search (yielding an O (log N) solution), and in languages
with hashes you'd use a hash (yielding an O (1) (expected) time solution).
Sure, the hash takes linear preprocessing time, but since we're asked
to write a script, we're spending linear time reading in the data
anyway.

Perhaps the intend was a subroutine which takes a matrix and a target
number, but that was not what is being asked. The challenge explicitly
asks for *a script*, which means we have to spend a linear amount of 
time reading data anyway. So, that's what you get.

The only part where we use the fact we are given a matrix is for the
input: the first five lines are assumed to contain the matrix. The
rest of the input is taken as numbers to search for.

Only for language lacking hashes/maps/dictionaries/tables, we will
make use of the fact the input is sorted. For the majority of
languages, the fact input is sorted does not offer additional benefits.

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [Perl](perl/ch-1.pl)

### Blog

## [Ordered Letters](https://perlweeklychallenge.org/blog/perl-weekly-challenge-111/#TASK2)

> Given a word, you can sort its letters alphabetically (case insensitive).
> For example, 'beekeeper' becomes 'beeeeekpr' and 'dictionary' becomes
> 'acdiinorty'.
>
> Write a script to find the longest English words that don't change when
> their letters are sorted.

### Notes
We will grep the words from standard input which don't change
if they are sorted; these are the words which match the pattern
/^a*b*c*...z*$/i. We keep track of the longest word.

If course, there does not have to be a unique word. It will depend
on the word list used to search in. For instance, three different
word list I used give different results:

    infochimps.com     /usr/share/dict/words     enable.lst
    --------------     ---------------------     ----------
                                     Adelops
          aegilops
                                     alloquy
                                     beefily        beefily
                                     begorry
                                     billowy        billowy
                                     egilops

Only one of them has a unique longest word.

We will be reading a word list from standard input, and write
the longest word where the letters are in alphabetical order
to standard output. In case of ties, we print the first one found.


### Solutions
* [GNU AWK](awk/ch-2.gawk)
* [Bash](bash/ch-2.sh)
* [C](c/ch-2.c)
* [Lua](lua/ch-2.lua)
* [Node.js](node/ch-2.js)
* [Perl](perl/ch-2.pl)
* [Python](python/ch-2.py)
* [Ruby](ruby/ch-2.rb)

### Blog

