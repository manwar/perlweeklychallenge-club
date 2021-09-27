# Perl Weekly Challenge #131

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-131/james-smith/perl

# Task 1 - Consecutive Arrays

***You are given a sorted list of unique positive integers. Write a script to return list of arrays where the arrays are consecutive integers.***

## The solution

There isn't much to the solution, we are going to return the data as an array of arrayrefs each containing consecutive numbers.

 * We start by creating our first arrayref containing the first value. {for the `if` code to work without an edge case we need in element in our first arrayref to compare against)
 * We then loop through the values:
   * if the next number is 1 greater than the last value in the last arrayref. We push it there,
   * otherwise we create a new arrayref and push it on the end of our array.
 * We "cheat" a bit with the `if` statement - by replace `if( $a ) { $b } else { $c }` with `($a) ? ($b) : ($c)` this means we can use it inline within a `foreach` loop.
 
```perl
sub conseq {
  my @val = @{$_[0]};
  my @res = ( [shift @val] );
  ( $_ == 1 + $res[-1][-1] ) ? (push @{$res[-1]},$_) : (push @res,[$_]) for @val;
  \@res;
}
```

# Task 2 - Find Pairs

***You are given a string of delimiter pairs and a string to search. Write a script to return two strings, the first with any characters matching the 'opening character' set, the second with any matching the 'closing character' set.***


## Solution

We solve this with a one liner.... which is below:

```perl
sub find_pairs {
  map { join '', $_[1] =~ /$_/g }
  map { '(['.quotemeta($_).'])' }
  map { join '', $_[0] =~ /$_/g }
  '(.).?', '.(.?)';
}
```

A bit of an explanation on this one....

 * Working backwards we define two regex `(.).` & `.(.)` these when combined with `/g` return alternate characters in the string
   either starting from the first char or the 2nd.
 * We then join these together to get two lists of characters.
 * We convert them into a regex by using quotemeta to remove the "specialness" and then wrapping them in "([ ])" to capture them
 * We just run this regex against our original string (with `/g` again) to get results.
