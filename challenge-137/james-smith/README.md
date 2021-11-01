# Perl Weekly Challenge #137

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-137/james-smith/perl

# Task 1 -  Long year

***Write a script to find all the years between 1900 and 2100 which is a Long Year.***

*Long years are those years with 53 weeks, they either start on a Thursday OR on a Wednesday in a Leap Year*

## The solution

```perl
my $start_day = 1;

foreach my $year ( 1900 .. 2100 ) {
  my $is_leap_year = ! $year % 4 && ( $year % 100 || ! $year % 400 );
  say $year if $start_day == 4 || $start_day == 3 && $is_leap_year;
  $start_day = ( $start_day + 1 + $is_leap_year ) % 7;
}
```

# Task 2 - Lychrel Number

***You are given a number, `10 <= $n <= 1000`. Write a script to find out if the given number is Lychrel number.***
 
*To keep the task simple, we impose the following rules: a. Stop if the number of iterations reached 500; b. Stop if you end up with number >= 10_000_000.*

## Solution

```perl
sub lychrel {
  my($n,$c) = (shift,$COUNT);
  ($n eq reverse $n) ? (return 0) : ($n+= reverse $n) while $c-- && $n <= $MAX;
  1;
}
```

```perl
sub lychrel_large {
  my ( $c, @n ) = ( $COUNT, split //, $_[0] );
  while( $c-- && @n <= $MAX_LARGE ) {
    return 0 if (join '', my @r = reverse @n ) eq (join '', @n); ## Check if palindromic
    ## Add the arrays as if numbers - note this is compact - but does the job!
    ( $n[$_] += $r[$_] ) > 9  && ($n[$_] -= 10, $_ ? ($n[$_-1]++) : (unshift @n, 1) ) foreach reverse 0 .. @n-1;
  }
  1;
}
```
