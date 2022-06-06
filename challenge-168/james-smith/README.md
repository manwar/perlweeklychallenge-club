[< Previous 167](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-167/james-smith) |
[Next 169 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-169/james-smith)

# The Weekly Challenge 168

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-168/james-smith

# Challenge 1 - Perrin Prime

***The Perrin sequence is defined to start with [3, 0, 2]; after that, term N is the sum of terms N-2 and N-3. (So it continues 3, 2, 5, 5, 7, ...) A Perrin prime is a number in the Perrin sequence which is also a prime number. Calculate the first 13 Perrin primes***


## Solution

Using our favourite is_prime library we loop through the Perrin numbers and checking to see if they are prime, if they are we display them - if not we restart the loop with `redo`.

Rather than keep the whole array we only need the last 3 numbers in the sequence to generate the next so we have: `$s -> $r`, `$t -> $s` and `$r+$s -> $t`. Once nice feature of perl is that you can do multiple parallel definitions inside a list. The final quirk you see here is `$t!=$` - there is one duplicate value in the list (5) which would mean we saw 5 twice in our output which we don't want....

```perl
my ($r,$s,$t)=(3,0,2);
($r,$s,$t)=($s,$t,$r+$s), is_prime($t) && $t!=$s ? (say $t) : (redo) for 1..13;
```
# Challenge 2 - Home Prime

***You are given an integer greater than 1. Write a script to find the home prime of the given number. In number theory, the home prime HP(n) of an integer n greater than 1 is the prime number obtained by repeatedly factoring the increasing concatenation of prime factors including repetitions.***

**Example: **
```
  10 = 2 x 5  ->   10
  25 = 5 x 5  ->   25
  55 = 5 x 11 ->  511
 511 = 7 x 73 ->  773
 773 = 773
```

So `HP(10) = 773`.

## Solution

Our favourite prime libray also has a `factor` function which returns a list of sorted prime factors (including duplicates). This simplfies the problem...

```perl
sub home_prime {
  return if (my$t=shift)<2;
  is_prime($t)?(return$t):($t=join'',factor$t)while 1;
}
```

We first check to see if the parameter passed in is `0` or `1` in which case we return nothing.
Otherwise if the value of the parameter is prime we return that and don't do anything else. o/w
we update it via the rule above and repeat
