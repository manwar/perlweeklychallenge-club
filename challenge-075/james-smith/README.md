Solutions by James Smith.

# Challenge 1 - Coins Sum

This is just begging for a recursive solution.

```perl
sub csm {
  my $t = shift;
  return @{$mem{"$t @_"}||=[map {my $a=$_; $t==$a?[$a]:
    map {[$a,@{$_}]} csm($t-$a,grep {$a<=$_&&$_<=$t} @_)} @_] };
}
```

Notes:

 * %mem is a memoisation cache as it helps to not need to re-compute higher totals more than once - speeds up searches for large coin sums... not essential but nice to have

How it works:

 * Loop through all coin values available
    * if the coin is the same as the amount required return a single array containing that value;
    * if not remove that from the amount required and call again. For all values returned prepend the coin value to each array in the list
    * when calling again remove any coins which are less than the "current coin" and greater than the amount required

Caveats & assumptions:

 * No input checking is performed - assumes the options passed are all valid and greater than 0;

# Challenge 2 - Histogram rectangle

Much simpler this time.

First we get the size of the box (max value) and render chart then we look for the maximum rectangle size - which is computed as the maximum value of the distance between any two points (inclusive)  multiplied by the lowest value in between the two values. (Maxi-min problem)
