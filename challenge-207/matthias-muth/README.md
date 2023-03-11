# Almost one-liners.
*Challenge 207 solutions in Perl by Matthias Muth*

## Task 1: Keyboard Word

> You are given an array of words.<br/>
> Write a script to print all the words in the given array that can be types
using alphabet on only one row of the keyboard.

Perl's regular expressions make this a simple task.<br/>
We just need to check whether the word that we examine consists of only
characters from one of the three sets of characters containing the keys of one
row of the keyboard. This is a regular expression that does that for us:
```perl
/^( [qwertyuiop]* | [asdfghjkl]* | [zxcvbnm]* )$/xi
```
The `x` modifier allows for whitespace in the pattern definition to make it
more readable,
and the `i` modifier makes sure that upper case as well as lower case
characters are matched.

The function that returns all 'single keyboard row' words from a list then
actually is a one-liner:
```perl
sub keyboard_words {
    return grep /^( [qwertyuiop]* | [asdfghjkl]* | [zxcvbnm]* )$/xi, @_;
}
```

## Task 2: H-Index

>You are given an array of integers containing citations a researcher has
received for each paper.<br/>
>Write a script to compute the researchers `H-Index`. For more information please checkout the [wikipedia page](https://en.wikipedia.org/wiki/H-index).

The Wikipedia page describes well how the `H-Index` can be computed from the
list of numbers of citations.
Starting with the list, sorted in descending order,
we can compare each number in the list with its index.
As long as the number is higher than the index, that publication counts for
the `H-Index`.
The `H-Index` then is the maximum of those indexes that match the criteria.

Instead of stopping at the last hit and using that index as a result,
we get the same result if we count all citations that fulfill the criteria.
As usual in Perl, there is more than one way to do it.
For me, the simplest one is to `grep` the indexes that match,
and then count them using the `scalar` operator. Like so:
```perl
sub h_index {
    my @sorted = sort { $b <=> $a } @_;
    return scalar grep $sorted[$_] >= 1 + $_, 0..$#sorted;
}
```

Ok, **almost** a one-liner...! ;-)


**Thank you for the challenge!**

