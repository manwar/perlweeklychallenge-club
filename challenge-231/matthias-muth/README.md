# On Perl's Home Ground
**Challenge 230 solutions in Perl by Matthias Muth**

## Task 1: Separate Digits

> You are given an array of positive integers.<br/>
> Write a script to separate the given array into single digits.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (1, 34, 5, 6)<br/>
> Output: (1, 3, 4, 5, 6)<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (1, 24, 51, 60)<br/>
> Output: (1, 2, 4, 5, 1, 6, 0)<br/>

This really is a simple challenge for Perl.<br/>
We can make full use of perl's type flexibility
to convert the numbers in the list into strings for concatenation,
without even needing to ask for it,
and then split the result into a list of characters, just like that:
```perl
use v5.36;

sub separate_digits( @ints ) {
    return split "", join "", @ints;
}
```

## Task 2: Count Words

> You are given an array of words made up of alphabetic characters and a prefix.<br/>
> Write a script to return the count of words that starts with the given prefix.<br/>
> <br/>
> Example 1<br/>
> Input: @words  = ("pay", "attention", "practice", "attend")<br/>
>        $prefix = "at"<br/>
> Ouput: 2<br/>
> Two words "attention" and "attend" starts with the given prefix "at".<br/>
> <br/>
> Example 2<br/>
> Input: @words  = ("janet", "julia", "java", "javascript")<br/>
>        $prefix = "ja"<br/>
> Ouput: 3<br/>
> Three words "janet", "java" and "javascripr" starts with the given prefix "ja".<br/>

Again, we are on Perl's home ground.<br/>
We can use a very simple regular expression to decide whether a word starts with the `$prefix`,
and get (and return) the number of matches from `grep` by putting it into a scalar context. 

```perl
use v5.36;

sub count_words( $words, $prefix ) {
    return scalar grep /^$prefix/, @$words;
}
```

## Note 1: Perl version
I am using
```perl
use v5.36;
```
to get function prototypes, `say` and many other useful 'modern' things,
without needing to list them all.
Love it!<br/>
If you don't have Perl 5.36, but at least 5.20, you can use this:
```perl
use strict;
use warnings;
use feature 'say';
use feature 'signatures';
no warnings 'experimental::signatures';
```

## Note 2: TestExtractor.pm
My [code](perl) also includes [`TestExtractor.pm`](perl/TestExtractor.pm),
which extracts the example test data from a text version of the challenge tasks
(extracted from the [website](https://theweeklychallenge.org/) by another script every monday ;-),
and runs the tests.

## 

#### **Thank you for the challenge!**
