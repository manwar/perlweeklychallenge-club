[< Previous 154](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-154/james-smith) |
[Next 156 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-156/james-smith)
# The Weekly Challenge #155

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-155/james-smith

# Challenge 1 - Fortunate Numbers

***Write a script to produce first 8 Fortunate Numbers (unique and sorted) - A Fortunate number, named after Reo Fortune, is the smallest integer `m > 1` such that, for a given positive integer `n`, `pn# + m` is a prime number, where the primorial `pn#` is the product of the first `n` prime numbers.***

## The solution

To make this easier we use the useful function `next_prime` from Math::Prime::Util. This finds the first prime greater than the parameter past.

We use it two ways:

  * To get the next prime in the list;
  * To find `m` by computing the next prime after the current prime product (we have to add 2 so that we avoid the one that is 1 higher than the product)

Doing this gives a list of unique fortunate numbers, which we then sort to display them

Note without doing an exhaustive search there may be a prime product for which `m` is `11` (for instance).

```perl
use Math::Prime::Util qw(next_prime);

my %res;

for(
  my $p = my $pp = 2;
  $pp < 1<<63;
  $pp *= $p = next_prime($p)
) {
  $res{ next_prime($pp+2) - $pp } = 1;
}

say for sort { $a <=> $b } keys %res;
```

# Challange 2 - Pisano Period

***Write a script to find the period of the 3rd Pisano Period. - In number theory, the nth Pisano period, written as π(n), is the period with which the sequence of Fibonacci numbers taken modulo n repeats.***

## The solution

For `n>1` we note that the repeated sequence must start with `1, 1` (and if it is `1, 1` the sequence will be repeated). We also realise we can avoid 2 loops in that the end of the sequence must be `1, 0`. Again we don't need to keep the whole finonacci sequence just the last two values.

```perl
sub pisano_period {
  return 1 if $_[0]==1;
  my ($n,$c,$p,$q) = (shift,2,1,1);
  $c++,($p,$q)=($q,($p+$q)%$n) while $q || $p!=1;
  return $c;
}
```

Notes:
 * The first line checks for the special case when `n=1` in which all values in the sequence are `0` so repeat has length 1.
 * `$c` is initialized as `2` as we are checking for the end of the loop not the beginning of the next... {so need to add the two initial values (1,1)}


