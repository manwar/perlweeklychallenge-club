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

## Solution a - can on move down and left or down and right

This doesn't match the output supplied (but feels right)
```perl
sub min_path {
  my @p = map { [0,[]] } 0,my @t = reverse @{$_[0]};
  for my $r (@t) {
    my($l,@q,$z) = shift @p;
    ( push @q, $l->[0] < $p[0][0]
       ? [ $_+$l->[0],  [ $_, @{$l->[1]}  ] ]
       : [ $_+$p[0][0], [ $_, @{$p[0][1]} ] ]
    ), $l = shift @p for @{$r};
    @p = @q;
  }
  $p[0][0];
}
```

## Solution b - can move to any node

This matches the output supplied (but feels wrong)

```perl
sub min_path_anydir {
  my $res = 0;
  foreach(@{$_[0]}) {
    my $min = 1e99;
    $min = $_ < $min ? $_ : $min for @{$_};
    $res+= $min;
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

