# Solutions by Abigail
## [Search Matrix](https://perlweeklychallenge.org/blog/perl-weekly-challenge-111/#TASK1)

> You are given 5x5 matrix filled with integers such that each row is
> sorted from left to right and the first integer of each row is greater
> than the last integer of the previous row.
>
> Write a script to find a given integer in the matrix using an
> efficient search algorithm.

### Notes

### Solutions

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
* [Perl](perl/ch-2.pl)

### Blog

