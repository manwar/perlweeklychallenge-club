[< Previous 191](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-191/james-smith) |
[Next 193 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-193/james-smith)

# The Weekly Challenge 192

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-190/james-smith

# Task 1 - Binary Flip

***You are given a positive integer, `$n`. Write a script to find the binary flip.***

## Solution

This isn't as simple as using `~` as this will flip ALL the bits including those before the first 1.

We need to therefore work through bit by bit reducing the number until we have reach zero.

We use the right shift operator to reduce `$n` each time. We have to push the values back onto the
answer. We can do this with addition - actually as we using bit-operators elsewhere we use the `|` operator

If the last digit is `1` we do nothing, if the last digit is `0` where add `2^$k` where $k is the
position we are currently checking. Note as we are right-shifting we have to increase `$k` each time.

```perl
sub binary_flip {
   my($r,$k,$n) = (0,0,shift);
   $r|=(~$n&1)<<$k++,$n>>=1 while $n;
   $r;
}
```

So instead we need to shift off the last bit until we get the zero value
# Task 2 - Equal Distribution

***You are given a list of integers greater than or equal to zero, `@list`. Write a script to distribute the number so that each members are same. If you succeed then print the total moves otherwise print `-1`***

## Solution

```perl
sub equal_dis {
  my($av,$k) = (0,0);
  $av+=$_ for @_;
  return -1 if $av%@_;
  $av/=@_;
  $k+=abs($av-$_[0]),$_[1]-=$av-shift while @_>1;
  $k;
}
```

The first thing to realise is that we only have a solution if the digits up to a multiple of the length of the list.

So first thing we do is work out the sum and see if it is divisible by the length.

Second is how to work out the number of steps. This is easier than you think. We only have to consider the case where we move numbers right to left or left to right, starting at the left. We are not bothered whether any number becomes negative.

So (1) how much do we need to move? This is simply `$av - $A[$p]`. So we borrow it from the next number so `$A[$p+1] = $A[$p+1] - $av + $A[$p]` and the number of steps is just `abs($av-$A[$p])`. Giving the code above.
