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

## Scrub that!

The previous solution is `O(n^2)`. But that is not optimal especially if we have a very large cross section. Can we write something which is `O(n)` or closer to `O(n)` - well yes we can - we can walk along the line to find the plateaux. A valley is defined to be the start of one plateau to the end of the next. Note the left and right hand points are defined to be plateaux for the purpose of the method.

So we keep some information:

 * current node is $_-1
 * `$pd` - the gradient to the left of the current node;
 * `$d`  - the gradient to the right of the current node;
 * `$s`  - the start of the left plateau;
 * `$s2` - the start of the right plateau;
 * `$S`  - start of largest valley;
 * `$E`  - end of largest valley;

A plateau starts if `$pd > 0` && `$d <= 0`, and ends if `$d > 0` && `$pd >= 0`. At any point we need to track two plateaux - firstly the one on the left of the current valley, and the one on the right (this will become the one on the left of the next valley)...

At the end of a plateau, we calculate the width of the valley as the distance from the current point to the start of the previous plateau. If it is greater than the previous best we update the start and end. We also set the start of the next "left hand side" plateau to the start of the right hand one.

Finally there is one last plateau we haven't looked at - and that is the one at the right hand end - so we check to see if this last value is wider than any previous ones...

```perl
sub valley2 {
  my( $pd, $s, $s2, $S, $E, $d ) = (0) x 5;
  for( 0 .. $#_-1 ) {
    $d  = $_[ $_+1 ] - $_[ $_ ];
    $s2 = $_                                                        if $pd > 0 && $d  <= 0; ## Start of plateau
    ( $_-$s > $E-$S ) && ( ( $S, $E ) = ( $s, $_ ) ) , ( $s = $s2 ) if $d  < 0 && $pd >= 0; ## End of plateau
    $pd = $d;
  }
  @_-$s2 > $E-$S+1 ? @_[ $s2 .. $#_ ] : @_[ $S .. $E ];
}
```

### Performance....

For the set examples the performance is around `1.8x` to `1.9x` that of the `O(n^2)` method. This is what you would expect for the magnitude of the test strings.

Adding in a very large entry shows how much better the 2nd algorithm is. We create a list of 330 points - the performance is approximately 40 times faster.
