[< Previous 152](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-152/james-smith) |
[Next 154 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-154/james-smith)
# The Weekly Challenge #153

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-153/james-smith

# Challenge 1 - Triangle Sum Path

***Write a script to compute Left Factorials of 1 to 10. It is the sum of all the factorials upto `n`***

## Solution

This is quite an easy caclulation - the `n+1`st left factorial is equal to the `n`nth left factorial + `n!`

Leading us to:

```perl
say my $t = $f = 1;
say $t += ($f*=$_) for 1..20;
```

to write out the first 21 (the largest number that can be represented as a an integer in 64bit perl) rather than 10
```
1
2
4
10
34
154
874
5914
46234
409114
4037914
43954714
522956314
6749977114
93928268314
1401602636314
22324392524314
378011820620314
6780385526348314
128425485935180314
2561327494111820314
```
# Challange 2 - Factorions

***You are given an integer, `$n`. Write a script to figure out if the given integer is factorion. A factorion is a natural number that equals the sum of the factorials of its digits.***

## Some notes

Firstly we need to note that (in base 10) that the largest Factorion would have at most 7 digits. For a given number of digits (m) the largest value of the sum of the digits is
`9! x m` or `362,880 x m`. For `m=7` we have the largest value being `2,540,160` which has 7-digits, for `m=8` we note that this value `2,903,040` also has 7 digits - so we can't have a solution with 8 or more digits.

So when we loop through possibly values we know the limit is actually `2,177,282` greatly reducing our search space.

## Solution

Our is factorion function just adds the factorial digit sum and compares to the number itself.

We start with a pre-computed list of factorials as we only need the values for the integers 0..9;

```perl
my @FACT = (1);
push @FACT, $_*$FACT[-1] foreach 1..9;

factorion($_) && say for 1..2_177_282;

sub factorion {
  my $t=0;
  $t+=$FACT[$_] for split //,$_[0];
  $t==$_[0];
}
```

Running this gives the only 4 factorions: `1`, `2`, `145`, `40585`;
