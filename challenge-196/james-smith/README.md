[< Previous 195](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-195/james-smith) |
[Next 197 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-197/james-smith)

# The Weekly Challenge 196

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-196/james-smith

# Task 1 -  Pattern 132

***You are given a list of integers, `@list`. Write a script to find out subsequence that respect Pattern 132. Return empty array if none found. Pattern 132 in a sequence `(a[i], a[j], a[k])` such that `i < j < k` and `a[i] < a[k] < a[j]`.***

## Solution
There is no simple solution other than looking at all pairs. (With a caveat there is short cut by skipping the inner loop if `$a[$j] <= $a[$i]`.
For the outer loop we can shift off the array to get `$x = $a[i]`. We can't do this for the inner loop, so we have to use the index `$i`...
But we can use the value for the inner loop by using an array slice `@_[$i+1..$#_]`

```perl
sub pattern132 {
  while(my$x=shift@_){
    for my $i (0..$#_-1) {
      next if $x > $_[$i];
      ($x<$_)&&($_<$_[$i])&&return $x,$_[$i],$_ for @_[$i+1..$#_]
    }
  }
  ()
}
```

# Task 2 - Range list 

***You are given a sorted unique integer array, `@array`. Write a script to find all possible Number Range i.e `[x, y]` represent range all integers from `x` and `y` (both inclusive). Each subsequence of two or more contiguous integers***

## Solution

We loop through the array one number at a time. We initialise our first interval as "`[$s,$e=$s]`" the `$s` is the first number.

We then loop through each subsequence number in turn.

  * If the new number is one more than the current end of the interval, we update the end and go to the next.
  * If it isn't we start a new interval "`[$s,$e=$s]`" - if the previous start and end had been different we push this to the results

Finally at the end of the loop if there is an interval left it is pushed to the list..

```perl
sub range {
  my$s=my$e=shift,my @r;
  ($_[0]==$e+1)?($e=shift):($s==$e||push(@r,[$s,$e]),$e=$s=shift)while @_;
  push@r,[$s,$e]unless$s==$e;
  @r
}
```

### version 2

That version is a bit messi - far too many variables!

This time we keep track of the intervals inside the result `@r`, we note that we don't need to discard the "empty" intervals while making the array - we can use grep to filter them out as we return the list. This makes the logic easier...

We start with an "empty" interval `[ $_[0],$_[0] ]`, and then we loop through the array if there is a gap we create a new "empty" interval and push to the list - o/w we just extend the last interval in the list... As we only want the "non-empty" intervals we just `grep` this at the end.

```perl
sub range_v2 {
  my @r = [ (shift) x 2 ];
  $_ == $r[-1][1] + 1 ? $r[-1][1] = $_ : push @r, [$_,$_] for @_;
  grep { $_->[1]-$_->[0] } @r
}
```
