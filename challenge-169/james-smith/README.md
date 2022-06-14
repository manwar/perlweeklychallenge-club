[< Previous 168](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-168/james-smith) |
[Next 170 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-170/james-smith)

# The Weekly Challenge 169

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-169/james-smith

# Challenge 1 - Brilliant numbers 

***Write a script to generate first 20 Brilliant Numbers.  Brilliant numbers are numbers with two prime factors of the same length.  The number should have exactly two prime factors, i.e. it’s the product of two primes of the same length.***


## Solution

```perl
for( my( $n, $c, $MAX, @f ) = ( 0, 0, @ARGV ? $ARGV[0] : 1e2 ); $c<$MAX; $n++ ) {
  say sprintf '%10d: %30d %10d %10d', ++$c, $n, @f
    if 2 == ( @f=factor($n) ) && length( $f[0] ) == length $f[1];
}
```

# Challenge 2 - Achilles Number

***Write a script to generate first 20 Achilles Numbers. An Achilles number is a number that is powerful but imperfect (not a perfect power). Named after Achilles, a hero of the Trojan war, who was also powerful but imperfect.  A positive integer n is a powerful number if, for every prime factor p of n, p^2 is also a divisor.  A number is a perfect power if it has any integer roots (square root, cube root, etc.).

## Solution

Our favourite prime libray also has a `factor` function which returns a list of sorted prime factors (including duplicates). This simplfies the problem...

```perl
for( my( $n, $c, $MAX ) = ( 2, 0, @ARGV ? $ARGV[0] : 1e2 ); $c<$MAX; $n++ ) {
  my %factors;
  $factors{$_}++ foreach factor $n;
  say sprintf '%6d: %15d - %s', ++$c, $n,
      join ' . ',
      map  { "$_^$factors{$_}" }
      sort { $a <=> $b }
      keys  %factors
    if 1 == gcd( grep { $_ < 2 ? next : 1 } values %factors )
}
```
