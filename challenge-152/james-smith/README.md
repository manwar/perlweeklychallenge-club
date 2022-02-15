[< Previous 151](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-151/james-smith) |
[Next 153 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-153/james-smith)
# The Weekly Challenge #152

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-152/james-smith

# Challenge 1 - Triangle Sum Path

***You are given a triangle array.  Write a script to find the minimum sum path from top to bottom.***

I'm going to outline two different solutions here - the first one is my first approach - which assumed that as
you went down the triangle you could only move to the next line either to the one adjacent to the left or the
right. The second solution removes this constraint and gives the answer in the question...

## Solution a - can on move down and left or down and right

This doesn't match the output supplied (but feels right). Note we are careful here to make the code "non-destructive" - care has to be taken that we do not shift/modify data from the rows passed in as this will affect the underlying structure. So we note that the `shift` is only done on the `@p` array of totals/paths.

We start by initalizing a blank row {below the triangle} we than work up the triangle one row at a time, the lowest value for a given cell is the value of the cell plus the lowest value of either the left or right cell below. In the code `$p[0]` is the left hand cell and `$p[1]` is the right hand cell.

Each time through the loop we generate a new version of `@p` with the best route for each entry. We can (with care) use a `map` to achieve this. We loop through each entry in the incoming data and combine this with the data for the two entries below. If the left hand entry is lower than the right we add the information from the left hand entry to the total, and to the list of numbers chosen to get there. We then need to remove the first entry of `@p` - we can do this with `shift @p` but we don't want that in the resultant array - to "hide" it we multiple the new array `($p[-1])` by `0` which gives us no copies of the array... bang the value we didn't want is gone...!

```perl
sub min_path {
  my @p = ( [0,[]] ) x (1 + @{$_[0]});
  @p = map { $p[0][0] < $p[1][0] ? [ $_+$p[0][0], [ $_, @{$p[0][1]} ] ] : [ $_+$p[1][0], [ $_, @{$p[1][1]} ] ], (shift @p) x 0 } @{$_} for reverse @{$_[0]};
  say sprintf 'Minimum value %d: [ %s ]', $p[0][0], join ', ', @{$p[0][1]};
  $p[0][0];
}

```

We can simplify this if we are not worried by the order - by storing a simple value (the minimum total for the path) rather than the pair total/path.

```perl
sub min_path_total {
  my @p = (0) x (1+@{$_[0]});
     @p = map { $_ + $p[$p[0]<$p[1]?0:1], (shift @p)x 0 } @{$_} for reverse @{$_[0]};
  $p[0];

}
```

## Solution b - can move to any node

This matches the output supplied (but feels wrong). In this case we just find the minimum value of each row and sum them together. Again we collect the values used in the path as we work down the triangle and display them at the end.

```perl
sub min_path_anydir {
  my ($res,@order) = 0;
  foreach(@{$_[0]}) {
    my $min = $_->[0];
    $_ < $min && ($min = $_) for @{$_};
    $res += $min;
    push @order, $min;   
  }
  say sprintf 'Minimum value %d: [ %s ]', $res, join ', ', @order;
  $res;
}
```

Again we can simplify this function by removing the need to store `@order`. This is simpler as we just need to remove the two lines containing `@order`. Giving us:

```perl
sub min_path_anydir_total {
  my $res = 0;
  foreach(@{$_[0]}) {
    my $min = $_->[0];
    $_ < $min && ($min = $_) for @{$_};
    $res += $min;
  }
  $res;
}
```
# Challange 2 - Rectangle Area

***You are given coordinates bottom-left and top-right corner of two rectangles in a 2D plane.  Write a script to find the total area covered by the two rectangles.***

## The solution

The area covered by the two rectangles is equal to the sum of the areas of the two rectangles minus the area of the intersection {as we count this twice}...

To compute the overlap we can define a bounding region..

```
   ####################---------+
   #                  #         |
   #            #################
   #            #     #         #
   #            #     #         #
   ####################         #
   |            #               #
   +------------#################
```

We note that the height of the bounding region is the *max-top* - *min-bottom* but is also *height-1* + *height-2* - *height-intersection* if they overlap. If they don't overlap it is greater than the sum of the heights.

So we can compute 3 heights:
  * height of rectangle 1,
  * height of rectangle 2, and
  * height of the bounding-box minus the heights of rectangles 1 and 2.

We do similarly for the 3 widths.

Then the area is `w1*12 + w2*h2` and if there is an itersection *i.e.* both w3 & h3 are positive - we subtract `w3*h3`.

This gives us the solution:

```perl
sub my_area {
  my ($l,$r,$L,$R) = @_; ## $l,$r are the bottom-left & top-right corners of rectangle 1
                         ## $L,$R are the bottom-left & top-right corners of rectangle 2

  ## Compute 3 widths and heights...

  my $w3 = ( my $w1  = $r->[0] - $l->[0]           )  ## width rectangle 1
         + ( my $w2  = $R->[0] - $L->[0]           )  ## width rectangle 2
         - ( $r->[0] > $R->[0] ? $r->[0] : $R->[0] )  ## right most point
         + ( $l->[0] < $L->[0] ? $l->[0] : $L->[0] ); ## left most point
  my $h3 = ( my $h1  = $r->[1] - $l->[1]           )  ## height rectangle 1
         + ( my $h2  = $R->[1] - $L->[1]           )  ## height rectangle 2
         - ( $r->[1] > $R->[1] ? $r->[1] : $R->[1] )  ## highest point
         + ( $l->[1] < $L->[1] ? $l->[1] : $L->[1] ); ## lowest point

  ## Return result...

  $w1*$h1 + $w2*$h2 - ($w3>0 && $h3>0 && $w3*$h3);
}
```

