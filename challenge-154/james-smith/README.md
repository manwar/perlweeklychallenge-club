[< Previous 152](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-152/james-smith) |
[Next 154 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-154/james-smith)
# The Weekly Challenge #152

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-154/james-smith

# Challenge 1 - Missing Permutation

***You are given possible permutations of the string 'PERL'. Find any missing ones***

# Challange 2 - Padovan Prime

***A Padovan Prime is a Padovan Number that’s also prime. The Padovan sequence is the sequence of integers P(n) defined by the initial values: P(0) = P(1) = P(2) = 1 and then the relationship P(n) = P(n-2) + P(n-3). Find the first 10 distinct solutions.***

## The solution

By using `is_prime` from the `Math::Prime::Util` we can quickly check to see if a number is prime. We then have to generate the Padovan sequence. We can generate the whole sequence - but that isn't needed for this problem we only need the values to create the next number, if we define these as `p, q, r` we note that to get the next one in the sequence we can define `(p',q',r') = (q,r,p+q);`

```perl
my$p=my$q=my$r=1;
($p,$q,$r)=($q,$r,$p+$q),$r!=$q&&is_prime($r)?say$r:redo for 1..10;
```

Expanding this out gives..

```perl
$p=$q=$r=1;

for (1..10) {
  ( $p, $q, $r ) = ( $q, $r, $p+$q );
  redo if     $r == $q;       ## skip (redo loop) if same as previous value
  redo unless is_prime($r);   ## skip (redo loop) if not prime
  say $r;                     ## output if we get here!
}
```

Note we use a *little used* perl construct - redo which restarts the loop without incrementing the counter. So in this case finds the next padovan number without incrementing the counter in the outside loop. So to find 10, we just loop from 1 to 10.
