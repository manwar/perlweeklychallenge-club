[< Previous 188](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-188/james-smith) |
[Next 190 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-190/james-smith)

# The Weekly Challenge 189

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-189/james-smith

# Task 1 - Greater Character

***You are given an array of characters (a..z) and a target character.  Write a script to find out the smallest character in the given array lexicographically greater than the target character.***


## Solution

```perl
sub greater_char {
  my $best;
  $_ gt $_[1] && !( defined $best && $_ ge $best ) && ($best=$_) for @{$_[0]};
  return $best || $_[1];
}
```

# Task 2 - Array Degree

***You are given an array of 2 or more non-negative integers.  Write a script to find out the smallest slice, i.e. contiguous subarray of the original array, having the degree of the given array.  The degree of an array is the maximum frequency of an element in the array.***

## Solution

We first define the "score" function `sc` which works out the degree of teh array.

We then loop through all contigous array splice (this has size `$n x ($n-1)`) looking for the smallets with the same score.

```perl
sub sc {
  my($v,%f)=0;
  $f{$_}++ for @_;
  ($_>$v)&&($v=$_) for values %f;
  $v
}

sub array_degree {
  my( $start, $end, $target ) = ( 0, $#_, sc( @_ ) );
  for my $st ( 0 .. @_ - $target + 1 ) {
    for ( $st + $target - 1 .. $#_ ) {
      last if     $_ - $st > $end - $start;
      next unless sc( @_[ $st .. $_ ] ) == $target;
      $start=$st, $end=$_;
      last;
    }
  }
  @_[$start..$end];
}
```
