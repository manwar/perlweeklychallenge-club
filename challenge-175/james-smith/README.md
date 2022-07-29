[< Previous 174](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-174/james-smith) |
[Next 176 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-176/james-smith)

# The Weekly Challenge 175

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-175/james-smith

# Task 1 - Last Sunday

***Write a script to list Last Sunday of every month in the given year.**

## Solution

```perl
my @L = (31,31,28,31,30,31,30,31,31,30,31,30,31);

sub last_day_of_months {
  my $yr = shift;
  $L[2] = (my $ly  = !( $yr%400 && ( ($yr%4) || !($yr%100) ) )) ? 29 : 28;
  my $last = 31 - ( int(($yr%100)/4) - $ly + 2 * (int(3 - $yr/100)%4) + $yr%100 ) % 7;
  map { ( ($last += 35 - $L[$_-1]) > $L[$_] ) && ($last-=7);
        sprintf '%04d-%02d-%02d', $yr, $_, $last
      } 1..12;
}
```
### Notes

The algorithm works by finding the last Sunday in December of the previous year (`$last`) and then walks forward a month at a time to find the last sunday in each month of the your.

We note the last Sunday in the month is either 4 or 5 weeks away so we can get the date by adding 35 days to the current last Sunday and seeing if that happens to be in the next month (if it isn't we subtract 7 days to get back into the correct month. We make adjustments for the length of the previous month, and repeat.

The computation is broken into two parts - we first work out if the year is a leap year {divisible by 4 but not 100 unless divisible by 400}

We use this value twice - once to modify the length of february - and once in the calulation for end of the previous year.

To get the last Sunday of December of the previous year we work out the day of the `0th` of January in our year of interest. This gives the day of the week of December 31st - we subtract this from 31 to get the last Sunday.

# Task 2 - Perfect Totient Numbers

***Write a script to generate first 20 Perfect Totient Numbers. In number theory, a perfect totient number is an integer that is equal to the sum of its iterated totients. Take n, compute it's totient, then compute it's totient and repeat. Then add values. The toient of a number is the count of numbers smaller than it that are co-prime.***

## Notes

**Sum of totients**

First thing we note is that the "sum of totients" (`S(n)`) for `n` is equal to the sum of the totient (`t(n)`) for `n` & the Sum of totients of that value.

```
   S(n) = t(n) + S( t(n) );
```

This reduces the problem to a recursive solution. So naturally we use a memoized (caching function) to store `S(n)` - State variables are useful here to store those values - each time you call the function they remember values before.. In this case the cache of `S(n)` values. We pre-populate 1 value in the cache when `n` is `1` the totient is `0` and so is the sum of `totients`. The first `0` is a pad so arrays are `0` based.

**Totient number**

Computing the `gcd(n,m)` for all `m` less than `n` gets hard to compute. So is there a way to avoid this - well yes there is!

If we generate a prime factorization of `n` then we can use this to quickly compute the totient.

If `n` = `p1^k1 . p2^k2 . ...` then we can simplify the calculation. For to be co-prime with `n` and number must be co-prime to `p1`, `p2`, .... For each `p` the number of co-primes in `p^k` numbers is `p^k - p^(k-1)` or `p^(k-1) . (p-1)`.

Furthermore we note that these are "orthogonal" and so the totient is the product of this value for all primes.

We use our favourite prime library and `factor_exp` to get this factorization and compute the product.

## Solution

```perl
sub sum_totients {
  state @T = (0,0);
  unless( defined $T[ $_[0] ] ) {
    my $z = 1;
    $z *= $_->[0]**($_->[1]-1) * ($_->[0]-1) for factor_exp $_[0];
    $T[ $_[0] ] = $z + sum_totients( $z );
  }
  $T[ $_[0] ];
}
```

We can rewrite this as a 1-liner using `List::Util`s product function.

Now there is a second nasty trick here - which if you are used to javascript *self-executing closure*. The trick allows us here to
use the result of the totient calculation and use it to calculate the `t(n) + S( t(n) )` calculation without a *temporary* variable.

The code reduces to, watch out for the two difference `$_[]` and the `$_->[]`...:

```perl
sub st {
  state @T = (0,0);
  $T[ $_[0] ] //= sub{$_[0]+st($_[0])}->(
                    product
                      map { $_->[0]**($_->[1]-1) * ($_->[0]-1) }
                      factor_exp $_[0]
                  );
}
```
