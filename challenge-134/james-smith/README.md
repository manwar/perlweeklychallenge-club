# Perl Weekly Challenge #134

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-134/james-smith/perl

# Task 1 -  Pandigital Numbers

***Write a script to generate first 5 Pandigital Numbers in base 10.***

## The solution

Pandigital numbers (base 10) are numbers who contain all the digits between 0-9 (but don't start with 0)
The lowest pandigital numbers all are permutations of the digits 0..9 with 0 not being the first digit.

To walk the pandigital numbers we can write a script which generates the next perumtation in "lexical" order. You don't need to do this recursively or with tightly nested loops a simple algorithm finds them...

 * Find the largest value of `$i` such that `$s[$i]` `<` `$s[$i+1]`
 * Find the largest value of `$j` such that `$s[$i]` `<` `$s[$j]`
 * Flip these to entries
 * Flip all entries from $i+1 to end of the list...

We note though that we don't have to start at 0123456789 (the lowest permutation) as all numbers starting with 0 are skipped. We can then pre-empty this loop by noting the largest permutation 0987654321 which isn't a pan-digital number, so when we find the next iteration we have our first pandigital number....

```perl
my @s = (0,reverse 1..9);

sub next_perm {
  my( $i, $j );
  ( $s[$_] < $s[$_+1] ) && ( $i = $_ ) foreach 0 .. @s-2;
  return unless defined $i;
  ( $s[$i] < $s[$_]   ) && ( $j = $_ ) foreach $i+1 .. @s-1;
  @s[ $i, $j       ] = @s[ $j, $i               ];
  @s[ $i+1 .. @s-1 ] = @s[ reverse $i+1 .. @s-1 ];
  return 1;
}

say @s while next_perm && $count--;
```

# Task 2 - Distinct Terms Count

***You are given 2 positive numbers, `$m` and `$n`. Write a script to generate multiplcation table and display count of distinct terms.***

## Solution

Number 2 again is the easier code this week...
We just loop through the two indicies and make a note of each product as a keys of a hash. And return scalar

```perl
  my($m,$n,%x) = @_;
  for my $i (1..$m) {
    $x{$i*$_}++ for 1..$n;
  }
  return scalar keys %x;
```

If `$m` & `$n` are large (and similar) there may be gain in separating the rectangle into a square and a rectangle - and only compute products for one half of the triangle...
