[< Previous 156](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-156/james-smith) |
[Next 158 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-158/james-smith)
# The Weekly Challenge 157

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-157/james-smith

# Challenge 1 - Pythagorean Means

***You are given a set of integers. Write a script to compute all three Pythagorean Means i.e Arithmetic Mean, Geometric Mean and Harmonic Mean of the given set of integers.***

## The solution

Computing the means is relatively straight forward. We just need to keep the sum of values, the product of values & the sum of their reciprocals.

Once we have these sums, it is easy to return the respective means - dividing by `$N`, taking the `$N`-th root and taking `$N` divided by the sum.

```perl
sub means {
  my ($am, $gm, $hm) = (0, 1, 0);
  $am+=$_, $gm*=$_, $hm+=1/$_ for @_;
  ( $am/@_, $gm**(1/@_), @_/$hm );
}
```

**Note** - we assume all integer values are not equal to `0`.

# Challenge 2 - Brazilian Number

***You are given a number `$n > 3`. Write a script to find out if the given number is a Brazilian Number. A positive integer number `N` has at least one natural number `B` where `1 < B < N-1` where the representation of N in base B has same digits.

## The solution

For any value of `$B` we can check that the digits are the same by repeated integer division. We first store the last digit `$last` below, and compare each digit with this value. If they are the not the same we jump out of the inner loop to the next value of the outer loop `next O`. So if they are the same it falls down to the `return 1;` inside the outer loop. If all fail we never get to the `return 1;` so return `0` from the last line of the function.
```perl
sub is_brazilian {
  O: for my $b (2..($_[0]-2)) {
    my $last = (my $n=$_[0])%$b;
    $n%$b==$last || next O while $n=int($n/$b);
    return 1;
  }
  0;
}
```

**Note** - `next {label}` is useful in many examples to jump out of inner loop without using *flag* variables to know whether the inner loop returned a *true* or *false* value.
