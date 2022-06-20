[< Previous 169](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-169/james-smith) |
[Next 171 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-171/james-smith)

# The Weekly Challenge 170

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-170/james-smith

# Challenge 1 - Primordial Numbers

***Write a script to generate first 10 Primorial Numbers - like factorials but multiply by succesive primes***


## Solution

```perl
my(@x)= my $p = 1;

push @x, $x[-1] * ($p = next_prime $p) for 1..100;

say sprintf '%300s', th($_) for @x;

sub th { scalar reverse( (reverse $_[0]) =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/gr ) }
```

# Challenge 2 - Kronecker Product

***Write a script to implement Kronecker Product on the given 2 matrices. e.g.***

## Example

Hard to describe - but here is an example.... see https://en.wikipedia.org/wiki/Kronecker_product
```
A = [ 1 2 ]
    [ 3 4 ]

B = [ 5 6 ]
    [ 7 8 ]

A x B = [ 1 x [ 5 6 ]   2 x [ 5 6 ] ]
        [     [ 7 8 ]       [ 7 8 ] ]
        [ 3 x [ 5 6 ]   4 x [ 5 6 ] ]
        [     [ 7 8 ]       [ 7 8 ] ]

      = [ 1x5 1x6 2x5 2x6 ]
        [ 1x7 1x8 2x7 2x8 ]
        [ 3x5 3x6 4x5 4x6 ]
        [ 3x7 3x8 4x7 4x8 ]

      = [  5  6 10 12 ]
        [  7  8 14 16 ]
        [ 15 18 20 24 ]
        [ 21 24 28 32 ]
```

## Solution


```perl
sub k_product {
  [ map { my$r = $_; map { my$t = $_; [ map { my$s=$_; map { $s*$_ } @{$t} } @{$r} ] } @{$_[1]} } @{$_[0]} ]
}

```

A slightly more compact version (73 characters!)
```perl
sub k{[map{$b=$_;map{$a=$_;[map{//;map{$'*$_}@$a}@$b]}@{$_[1]}}@{$_[0]}]}
```
