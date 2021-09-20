# Perl Weekly Challenge #130

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-130/james-smith/perl

# Task 1 - Consecutive Arrays

***You are given a sorted list of unique positive integers. Write a script to return list of arrays where the arrays are consecutive integers.***

## The solution

```perl
sub conseq {
  my @val = @{$_[0]};
  my @res = ( [shift @val] );
  ( $_ == 1 + $res[-1][-1] ) ? (push @{$res[-1]},$_) : (push @res,[$_]) foreach @val;
  return \@res;
}
```

# Task 2 - Find Pairs

***You are given a string of delimiter pairs and a string to search. Write a script to return two strings, the first with any characters matching the 'opening character' set, the second with any matching the 'closing character' set.***


## Solution

We solve this with a one liner.... which is below:

```perl
sub find_pairs {
  return map { join '', $_[1] =~ /$_/g }
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
