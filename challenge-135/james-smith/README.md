# Perl Weekly Challenge #135

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-135/james-smith/perl

# Task 1 -  Middle three digits

***You are given an integer. Write a script find out the middle 3-digits of the given integer, if possible otherwise throw sensible error.***

## The solution

Obviously using `substr $n, ??, 3` will give a 3-digit chunk of a number - so what are the errors...

 * Not an integer - doesn't match `/^-?\d+$/`
 * Less than 3 digits - length less than 3
 * Does not have a unique "central 3-digits" *i.e.* has even length

The value of the `??` is the expression above - `( length number - 3 ) / 2`

All that gives us the simple function....

```perl
sub middle3 {
  my $n = shift;
  return 'Not a number' unless $n =~ m{^-?\d+$};
  my $l = length( $n = abs $n );
  return $l < 3 ? 'Too short'
       : $l % 2 ? substr $n, ( $l - 3 ) / 2, 3
       :          'Even digits'
       ;
}
```

It is possible to compact this slightly - buy 1 - assuming `$n` is an integer, and then rewriting `($l-3)/2` as `$l/2-1` - which is good enough for the `substr` to work.

```perl
sub middle3compact {
  my$l=length(my$n=abs$_[0]);
  return$l<3?'Too short':$l%2?substr$n,$l/2-1,3:'Even digits';
}
```

# Task 2 - Validate SEDOL

***You are given 7-characters alphanumeric SEDOL. Write a script to validate the given SEDOL. Print 1 if it is a valid SEDOL otherwise 0.***

## Solution

You find about SEDOL numbers on Wikipedia at https://en.wikipedia.org/wiki/SEDOL.

The consist of 6 digits/consonants + a checksum digit. The weighted sum of the 6 digits + the checksum is a multiple of 10.
The weights are 1, 3, 1, 7, 3 and 9 for the six digits and the checksum.

We have to:
 * validate the number is a SEDOL number
 * compute the weighted sum
 * check to see if it is a multiple of 10

```perl
sub is_sedol {
## Check correct format... numbers and consonants only
  return 0 unless $_[0] =~ m{^[0-9B-HJ-NP-TW-Z]{6}\d$};

## Accumulator and weights for each charachter
  my( $t, @w ) = qw(0 1 3 1 7 3 9 1);

## Calculate SEDOL sum... note YODA sum -55 + ord $_ to avoid precedence issue
  $t += ( /\d/ ? $_ : -55 + ord $_ ) * shift @w for split //, $_[0];

## Return true (1) if total modulo 10 is 0, and false (0) otherwise
  return $t % 10 ? 0 : 1;
}
```
Again we can compact the code - by removing spaces and a couple of rewrites:

 * replace `unless $x=~//` with `if $x!~//`;
 * flip `@w` and use `pop`.
 
```perl
sub is_sedol_compact {
  return 0if$_[0]!~/^[0-9B-HJ-NP-TW-Z]{6}\d$/;
  my($t,@w)=qw(0 1 9 3 7 1 3 1);
  $t+=(/\d/?$_:-55+ord$_)*pop@w for split//,$_[0];
  $t%10?0:1;
}
```
