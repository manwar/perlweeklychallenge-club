[< Previous 203](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-203/james-smith) |
[Next 205 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-205/james-smith)

# The Weekly Challenge 204

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-204/james-smith

# Task 1: Monotonic Array

***You are given an array of integers. Write a script to find out if the given array is Monotonic. Print 1 if it is otherwise 0. An array is Monotonic if it is either monotone increasing or decreasing.***

## Solution

We loop through the array - firstly trying to find if the string is increasing or decreasing.

To do so we collect ths sign of the difference between successive numbers UNTIL we find a non-zero value..

We then see if all subsequence differences have the same sign (or 0)....

```perl
sub monotonic {
  my($p,$d,$t)=$_[0];
  ($t=$p<=>$_)&&($d||=$t)!=$t?(return 0):($p=$_)for@_;
  1
}
```

```perl
sub monotonic {
  my($p,$d,$t)=($_[0],0);
     ($t=$p<=>$_)        ## Get next signum of the pairwise difference (and store in $t) 
  && ($d||=$t) != $t     ## If this new difference is non-zero
                         ##   we update the direction [IF it is previously non-zero]
                         ##   and compare it against the value we have just computed
   ? (return 0)          ## If the difference is different we return 0
   : ($p=$_)             ## Otherwise we update the previous value...
   for @_;               ## and repeat for all values.
  1;                     ## We have no differences!
}
```

# Task 2: Reshape Matrix

***You are given a matrix (m x n) and two integers (r) and (c). Write a script to reshape the given matrix in form (r x c) with the original value in the given matrix. If you can’t reshape print 0.***

Our first pass - is simple - we first do a dimension check to see if the matrix is the right size. Then we stitch all the rows together into a single list, and chomp off line-by-line.

```perl
sub reshape {
  my($m,$r,$c) = @_;
  return 0 unless @{$m}*@{$m->[0]} == $r * $c;
  my @t = map { @{$_} } @{$m};
  [ map { [ splice @t, 0, $c ] } 1..$r ];
}
```

Our second pass is a bit more complicated as we try and avoid the stitch everything together in a long line...

 * Here we start again with the size check then we construct each row of the target array, chunk by chunk,
 * We find the part of the of the first row of the source which will fit in the target row.
    * If we reach the end of the target row - we push this to our target matrix
    * If it does not we repeat again adding bits of the 2nd, 3rd,... rows of the source to the target.
 * We repeat for all rows - noting that we may NOT start at the beginning of a source row - but at `$x` are cursor position.

This method is more efficient memory wise - a consideration if you are reshaping a large matrix.

```perl
sub reshape2 {
  my($m,$r,$c) = @_;
  my $R=@{$m}; my $C = @{$m->[0]};
  return 0 unless (my $R=@{$m}) * (my $C=@{$m->[0]}) == $r * $c;
  my($x,$y,$res)=(0,0);
  for my $i (1..$r) {
    my $row = [];
    my $to_push = $c;
    while( $to_push ) {
      my $t = $to_push+$x<$C?$to_push+$x:$C;
      push @{$row},@{$m->[$y]}[$x..$t-1];
      $to_push -= $t-$x;
      $t==$C ? ($y++,$x=0) : ($x=$t);
    }
    push @{$res},$row;
  }
  $res
}
```
