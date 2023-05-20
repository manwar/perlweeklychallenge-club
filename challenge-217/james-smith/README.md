[< Previous 216](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-216/james-smith) |
[Next 218 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-218/james-smith)

# The Weekly Challenge 217

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-217/james-smith

# TASK #1: Sorted Matrix

***You are given a n x n matrix where n >= 2. Write a script to find `3rd smallest` element in the sorted matrix.***

## Solutions

### Naive solution

Our naive solution is to unravel the matrix into a single list `map{@$_}@_`, sort it and find the 3rd entry (index `2`). We then have a nice one liner....

```perl
sub sorted_matrix {
  [ sort { $a <=> $b } map {@{$_}} @_ ]->[2]
}
```

This is good because it uses a built in method `sort` which will be faster than writing it in perl code - and it is `O(n.log n)` which is good. But it is still `O(n.log n)`. As we are looking for the 3rd smallest entry we can scan the matrix and just keep track of the smallest ones - this would be `O(n)`, but obviously more computationally expensive for each loop. But how much...

### Second solution:

We again flatten the matrix, but this time we take the first three entries and sort into order.
Then we loop through all the other values, and replace any values in this list by the new value
if required.

If we compare the performance against the naive solution we find that the naive solution is better then this method for the small matrices in the the example. BUT if we increase the size of the matrix to 10x10 then we find they are comparable in performance. If we then go up to 20x20 we can see the advantage of this solution.

```perl
sub sorted_matrix_x {
  @_=map{ @{$_} } @_;

  my( $x, $y ,$z ) = splice @_,0,3; ## Grab 3 values;

  ( $x, $y     ) = ( $y, $x ) if $y<$x;
  $z < $x ? ($x,$y,$z) = ($z,$x,$y) : $z < $y && ( ($y,$z)=($z,$y) );

  $_<$z && (
      $_<$x ?  ( $x, $y, $z ) = ( $_, $x, $y )
    : $_<$y ?  (     $y, $z ) = (     $_, $y )
    :          (         $z   =           $_ )
  ) for @_;
  $z
}
```

### Third solution:

But can we go faster - what can slow us down. One thing we still do is flatten the matrix - that is a relatively expensive operation, but it does need slightly more code around it - mainly related to the calculation of the first 3 values.

But we can work around it - we shift of values from the first row of the array, and if that list is empty - we move on to the next row... and the next...
Finally we loop through each row of the array (including the remains of this row) and perform the same insertion step as above...

Although more complex - is it faster? yes - the break even point against the first technique is around `5x5`. The extra work means this method performance increases linearly even to the 2nd method...

```perl
sub sorted_matrix_xx {
  my @row = @{pop()};

  my $x = pop @row; @row = @{pop()} unless @row;
  my $y = pop @row; @row = @{pop()} unless @row;
  my $z = pop @row;

  ( $x, $y     ) = ( $y, $x ) if $y<$x;
  $z < $x ? ($x,$y,$z) = ($z,$x,$y) : $z < $y && ( ($y,$z)=($z,$y) );
  for(\@row,@_) {
    $_<$z && (
        $_<$x ?  ( $x, $y, $z ) = ( $_, $x, $y )
      : $_<$y ?  (     $y, $z ) = (     $_, $y )
      :          (         $z   =           $_ )
    ) for @{$_};
  }
  $z;
}
```
Firstly we get a list of the lower-cased letters in the number plate. Then for each word in turn we:
 * copy this hash into a temporary hash;
 * remove any letters from hash which rea in the word;
 * Check to see if the hash is now empty - if it is we include the word.

### Performance

For small arrays (<3) then the `sort` and pick is the fastest method, at which point method 3 passes it, and around 7-10 method 2 also passes it, showing the overhead of the "copy" of the matrix. The difference between methods 2 and 3. By the time we get to a 20x20 matrix, method 2 is twice the speed of the sort and method 3 is 6 times the speed of the sort.

# TASK #2: Max Number

***You are given a list of positive integers. Write a script to concatenate the integers to form the highest possible value.***

## Solution

A naive solution would be to just (string) sort the elements ans stitch them together - but that isn't the case as if you stitch `1` & `10` together in alphabetical order you get `10`` not `110`. So instead we compare `$a.$b` with `$b.$a` which resolves this.

```perl
sub max_number      { join '', sort { $b.$a cmp $a.$b } @_ }
```
You can get the right answer with a numeric comparison - but the string comparison is between 10% & 20% faster.
