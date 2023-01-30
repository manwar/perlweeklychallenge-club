[< Previous 201](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-201/james-smith) |
[Next 203 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-203/james-smith)

# The Weekly Challenge 202

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-202/james-smith

# Task 1: Consecutive Odds

***You are given an array of integers. Write a script to print `1` if there are **THREE** consecutive odss in the given array otherwise print `0`.***

## Solution

We have to loop through a window of size 3 and check all three values are odd. We can do this with a single check. The 3 values will be ODD if and only if they all have the "0" bit set. So we can binary `&` them together and check the last bit by anding with `1`.

So we loop through - check this is the case - and if not move to the next value.

```perl
sub odd3 {
  return 0 unless @_>2;
  my $p = shift, my $q = shift;
  $p&$q&$_[0]&1 ? (return 1) : (($p,$q)=($q,shift)) while @_;
  0;
}
```

# Task 2:Widest Valley

***Given a profile as a list of altitudes, return the leftmost widest valley. A valley is defined as a subarray of the profile consisting of two parts: the first part is non-increasing and the second part is non-decreasing. Either part can be empty.***

## Solution

So we need a decreasing sequence followed by an increasing sequence.

Firstly we convert the valley heights into a string of difference (or more precisely whether that difference is `+1`, `-1` or `0`. We can use `<=>` to do that. We use `List::MoreUtils`'s `slide` method to do this.

We look for a sequence which only contains `-1`s before `+1`s.

We loop through all possible starts and see what the longest valley is.

Finally we return that interval.

```perl
sub valley {
  my( $L, $R, @d )=( 0, 0, slide { $b <=> $a } @_ );
  for my $l ( 0 .. $#d-1) {
    my($x,$t) = ( $d[$l] || -1, $l );
    while($t++<$#d) {
      $d[$t] && ( $d[$t]<$x ? last : ($x=$d[$t]) )
    }
    ($L,$R)=($l,$t) if $R-$L<$t-$l;
  }
  @_[$L..$R];
}
```
