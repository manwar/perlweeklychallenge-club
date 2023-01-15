[< Previous 198](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-198/james-smith) |
[Next 200 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-200/james-smith)

# The Weekly Challenge 198

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-199/james-smith

# Task 1 - Good Pairs

***You are given a list of integers, `@list`. Write a script to find the total count of Good Pairs. A pair `(i, j)` is called good if `list[i] == list[j]` and `i < j`.***

## Solution

This problem can be reduced to a simpler problem - We note for any number - the contribution will be equal to the number of distinct pairs of the number - so if it has a frequence of `n` - then the number of good pairs containing that number are `n(n-1)`. We add these up and then divide by `2` as each pair is counted twice..

We use a hash as a simple way to count each number! We then throw away the keys and add the computed values up and then return the value!
```perl
sub good_pairs {
  my($c,%f);
  $f{$_}++ for @_;
  $c+=$_*($_-1) for values %f;
  $c/2;
}
```

Note we could have used an external `freq` and `sum` method. To simplify this to:

```
sub good_pairs_fn {
  ( sum map{$_*($_-1)} values %{freq(@_)} ) /2;
}
```
# Task 2 - Good Triplets

***You are given an array of integers, `@array` and three integers `$x`,`$y`,`$z`. Write a script to find out total Good Triplets in the given array. 
A triplet `array[i]`, `array[j]`, `array[k]` is good if it satisfies the following conditions:***

  * `0 <= i < j < k <= n`
  * `abs(array[i] - array[j]) <= x`
  * `abs(array[j] - array[k]) <= y`
  * `abs(array[i] - array[k]) <= z`

## Solution

If you look in the source code you will find a few different methods - but I will outline a few places where gains are made and then include the fastest solution.

One naive approach could be:

```perl
sub good_triples_naive {
  my($c,$x,$y,$z) = (0,splice @_, 0, 3 );
  for my $i ( 0..$#_-2 ) {
    for my $j ( $i+1..$#_-1 ) {
      for ( $j+1..$#_ ) {
        $c++ if abs($_[$i]-$_[$j])<= $x
             && abs($_[$j]-$_[$_])<= $y
             && abs($_[$i]-$_[$_])<= $z;
      }
    }
  }
  $c;
}
```

The things we note:
 1. We perform the check `abs($_[$i]-$_[$j])<= $x` everytime in the inner loop
 2. We use a lot of array references `$_[$i]``, `$_[$j]`...
 3. We use a built in function `abs`

All these slow us down.

So **1** is easy to solve we move that condition into an if to avoid the inner loop. For tidyness we invert the condition and use `next`...

**2** we can copy `$_[$i]`, `$_[$j]`, `$_[$_]` into variables - there is an overhead in this - replacing `$_[$i]` & `$_[$j]` improves performance but the inner one slows things down (overhead of "copy" vs overhead of reference)

**3** we can convert the `abs` condition into a range. `abs($_1-$_2) <= $x`

can be written as `-$x <= $_1-$_2 && $_1-$_2 <= $x`

can be written as `$_1-$x<=$_ && $_2<=$_1+$x`

This just doesn't remove the call to `abs` but aslo a subtraction - as we can precompute `$_1-$x` & `$_1+$x`.

This gives us

```perl
sub good_triples_range_2 {
  my($c,$x,$y,$z,$_1,$_2,$lx,$ux,$lz,$uz,$ly,$uy)=(0,splice@_,0,3);
  for my $i ( 0..$#_-2 ) {
    ($lx,$ux,$lz,$uz) = (($_1 = $_[$i])-$x, $_1+$x,$_1-$z,$_1+$z);
    for my $j ( $i+1..$#_-1 ) {
      $_2 = $_[$j];
      next if $_2 < $lx || $_2 > $ux;
      ($ly,$uy) = ($lz>$_2-$y?$lz:$_2-$y,$uz<$_2+$y?$uz:$_2+$y);
      for ( $j+1..$#_ ) {
        $c++ if $ly <= $_[$_] && $_[$_] <= $uy;
      }
    }
  }
  $c;
}
```

Note in the inner loop we merge the ranges so reducing the comparisons even further.

### Bonus - how can we get this faster

How can we get this faster - This O(3) whatever happens can we reduce the time in anyway...

Other than what we've done - the only way to improved performance is to reduce the number of times we loop. Well the inner loop we can't change - the outer loop we can't change - but what about the inner loop... Heuristically the efficiency of the filter is proportional to `$x`. So if we chose the smallest `$x` we get the best result..

We can't change order but we can choose the *order* of the loops. This gives us the code from hell...

```perl
sub good_triples_fastest {
  my($c,$xy,$yz,$xz,$l,$u,$lx,$ux,$ly,$uy,$lz,$uz,$i,$j,$k,$x,$y,$z)=(0,splice@_,0,3);

  if($xy<=$xz&&$xy<=$yz){
    for $i ( 0 .. $#_-2 ) {
      ( $ly, $uy, $lz, $uz ) = ( ($x=$_[$i])-$xy, $x+$xy, $x-$xz, $x+$xz );
      for $j ( $i+1 .. $#_-1 ) {
        next if ($y=$_[$j]) < $ly || $uy<$y;
        ( $l, $u ) = ( $lz > $y-$yz ? $lz : $y-$yz, $uz < $y+$yz ? $uz : $y+$yz );
        $l <= $_[$_] && $_[$_] <= $u && $c++ for $j+1 .. $#_
      }
    }
  } elsif ( $yz<=$xz ) {
    for $j ( 1 .. $#_-1 ) {
      ( $lz, $uz, $lx, $ux ) = ( ($y=$_[$j])-$yz, $y+$yz, $y-$xy, $y+$xy );
      for $k ( $j+1 .. $#_ ) {
        next if ($z=$_[$k]) < $lz || $uz < $z;
        ( $l, $u ) = ( $lx > $z-$xz ? $lx : $z-$xz, $ux < $z+$xz ? $ux : $z+$xz );
        $l <= $_[$_] && $_[$_] <= $u && $c++ for 0 .. $j-1
      }
    }
  } else {
    for $i ( 0..$#_-2 ) {
      ( $ly, $uy, $lz, $uz ) = ( ($x=$_[$i])-$xy, $x+$xy, $x-$xz, $x+$xz );
      for $k ( $i+2..$#_ )  {
        next if ($z=$_[$k]) <$lz || $uz < $z;
        ( $l, $u ) = ( $ly > $z-$yz ? $ly : $z-$yz, $uy < $z+$yz ? $uy : $z+$yz );
        $l <= $_[$_] && $_[$_] <= $u && $c++ for $i+1 .. $k-1;
      }
    }
  }
  $c;
}
```

Looks nasty - but it is just three copies of the code above - the first called if `$x` is smallest, the second if `$y` is smallest and lastly when `$z` is the smallest.

### Performance

When the list is short it doesn't really matter about performance - but with the tests above with the longer list we have:

|          |   Rate | naive |  opt | copy_1 | range_1 | copy_2 | range_2 | fastest |
| -------- | -----: | ----: | ---: | -----: | ------: | -----: | ------: | ------: |
| naive    | 14.6/s |    -- | -43% |   -50% |    -52% |   -57% |    -64% |    -85% |
| opt      | 25.6/s |   75% |   -- |   -12% |    -15% |   -24% |    -36% |    -73% |
| copy_1   | 29.1/s |   99% |  13% |     -- |     -4% |   -14% |    -28% |    -70% |
| range_1  | 30.2/s |  106% |  18% |     4% |      -- |   -10% |    -25% |    -69% |
| copy_2   | 33.6/s |  130% |  31% |    16% |     11% |     -- |    -17% |    -65% |
| range_2  | 40.3/s |  176% |  57% |    39% |     33% |    20% |      -- |    -58% |
| fastest  | 96.3/s |  558% | 275% |   231% |    219% |   186% |    139% |      -- |
