# Perl Slices Make a Valid Point

**Challenge 334 solutions in Perl by Matthias Muth**

## Task 1: Range Sum

> You are given a list integers and pair of indices..<br/>
> Write a script to return the sum of integers between the given indices (inclusive).
>
> **Example 1**
>
> ```text
> Input: @ints = (-2, 0, 3, -5, 2, -1), $x = 0, $y = 2
> Output: 1
> 
> Elements between indices (0, 2) => (-2, 0, 3)
> Range Sum: (-2) + 0 + 3 => 1
> ```
>
> **Example 2**
>
> ```text
> Input: @ints = (1, -2, 3, -4, 5), $x = 1, $y = 3
> Output: -3
> 
> Elements between indices (1, 3) => (-2, 3, -4)
> Range Sum: (-2) + 3 + (-4) => -3
> ```
>
> **Example 3**
>
> ```text
> Input: @ints = (1, 0, 2, -1, 3), $x = 3, $y = 4
> Output: 2
> 
> Elements between indices (3, 4) => (-1, 3)
> Range Sum: (-1) + 3 => 2
> ```
>
> **Example 4**
>
> ```text
> Input: @ints = (-5, 4, -3, 2, -1, 0), $x = 0, $y = 3
> Output: -2
> 
> Elements between indices (0, 3) => (-5, 4, -3, 2)
> Range Sum: (-5) + 4 + (-3) + 2 => -2
> ```
>
> **Example 5**
>
> ```text
> Input: @ints = (-1, 0, 2, -3, -2, 1), $x = 0, $y = 2
> Output: 1
> 
> Elements between indices (0, 2) => (-1, 0, 2)
> Range Sum: (-1) + 0 + 2 => 1
> ```

Wait, what?<br/>
The elements between two indexes?<br/>As if Perl didn't have *array slices*...!<br/>It's just `@ints[$x..$y]`!<br/>OK, if we consider that the `@ints` array is passed in as a reference, it's `$ints->@[$x..$y]`.

And summing up?<br/>Too lazy to write a loop. I'll use `sum` from `List::Util`.<br/>Maybe it's good to save my energy for Task 2... :wink:

```perl
use v5.36;
use List::Util qw( sum );

sub range_sum( $ints, $x, $y ) {
    return sum( $ints->@[$x..$y] );
}
```

## Task 2: Nearest Valid Point

> You are given current location as two integers: x and y. You are also given a list of points on the grid.<br/>
> A point is considered valid if it shares either the same x-coordinate or the same y-coordinate as the current location.<br/>
> Write a script to return the index of the valid point that has the smallest Manhattan distance to the current location. If multiple valid points are tied for the smallest distance, return the one with the lowest index. If no valid points exist, return -1.<br/>
> <br/>
> The Manhattan distance between two points (x1, y1) and (x2, y2) is calculated as: |x1 - x2| + |y1 - y2|
>
> **Example 1**
>
> ```text
> Input: $x = 3, $y = 4, @points ([1, 2], [3, 1], [2, 4], [2, 3])
> Output: 2
>
> Valid points: [3, 1] (same x), [2, 4] (same y)
>
> Manhattan distances:
>     [3, 1] => |3-3| + |4-1| = 3
>     [2, 4] => |3-2| + |4-4| = 1
>
> Closest valid point is [2, 4] at index 2.
>```
> 
>**Example 2**
> 
>```text
> Input: $x = 2, $y = 5, @points ([3, 4], [2, 3], [1, 5], [2, 5])
> Output: 3
> 
>Valid points: [2, 3], [1, 5], [2, 5]
> 
>Manhattan distances:
>  [2, 3] => 2
>     [1, 5] => 1
>     [2, 5] => 0
>    
>Closest valid point is [2, 5] at index 3.
> ```
>
> **Example 3**
>
> ```text
>Input: $x = 1, $y = 1, @points ([2, 2], [3, 3], [4, 4])
> Output: -1
> 
> No point shares x or y with (1, 1).
>```
> 
>**Example 4**
> 
>```text
> Input: $x = 0, $y = 0, @points ([0, 1], [1, 0], [0, 2], [2, 0])
>Output: 0
> 
> Valid points: all of them
> 
>Manhattan distances:
>  [0, 1] => 1
> [1, 0] => 1
>  [0, 2] => 2
>     [2, 0] => 2
>    
>    Tie between index 0 and 1, pick the smaller index: 0
>    ```
>
> **Example 5**
>
> ```text
>Input: $x = 5, $y = 5, @points ([5, 6], [6, 5], [5, 4], [4, 5])
> Output: 0
>
> Valid points: all of them
>  [5, 6] => 1
>  [6, 5] => 1
> [5, 4] => 1
>  [4, 5] => 1
>    
>    All tie, return the one with the lowest index: 0
>    ```

#### The Long Solution (using a `for` loop):

I will start by constructing a more 'traditional' solution (even if it uses several concepts of 'modern' Perl).<br/>It will be based on a programmed-out `for` loop.  

Some thoughts:

* We need to return the *index* of the closest 'valid' point (not the point itself, nor its distance from ( \$x, \$y )). That means that when we filter out the points that are 'valid', we must maintain their index into the *original* point list.<br/>This means that we need to use the index into the point list as a driver for the loop rather than the points themselves. So instead of iterating over the points, like
  ```perl
      for my $point ( $points->@* ) { ... }
  ```
  we need to do this:
  ```perl
      for my $index ( keys $points->@* ) {
          my $point = $points->[$index];
          ...;
      }
  ```

* Starting with Perl 5.36, however, we can use multiple (lexical) loop variables with `for`/`foreach` loops. <br/>
  Together with the `indexed` builtin, also available since Perl 5.36,
  we can loop over index and point at the same time, with a more concise syntax:

  ```perl
      for my ( $index, $point ) ( indexed $points->@* ) {
          ...;
      }
  ```

* If the point's x-coordinate is equal to `$x` or the point's y-coordinate is equal to `$y`, the point is 'valid'.
  All other points need to be ignored.<br/>
  Once we know that the point's x-coordinate is equal to `$x`,
  the distance in the x dimension is zero,
  and the point's Manhattan distance is reduced to the y dimension:
  `abs( $y - $point->[1] )`.<br/>
  The same for the y-coordinate being equal to `$y`, of course:
  `abs( $x - $point->[0] )`.<br/>
  If none of the equalities show up, we can directly start the next iteration. In Perl, we are lucky that statements (here, the `next` statement) can also be used within expressions, not only as separate statements. (Thank you, James Curtis-Smith, for giving me that idea in your [Challenge 325 solution](https://www.facebook.com/groups/perlcommunity/permalink/1954898661984417/)!).<br/>
  So we can combine the Manhattan distance calculation and the filtering in one statement within the loop:

  ```perl
      for my ( $index, $point ) ( indexed $points->@* ) {
          my $distance = 
              $point->[0] == $x   ? abs( $y - $point->[1] )
              : $point->[1] == $y ? abs( $x - $point->[0] )
              : next;
          ...
      }
  ```

* For finding the index with the closest distance, we add some 'traditional' minimum finding code. We need to keep the best index as well as the closest distance, and update after a comparison in the loop.

  ```perl
      my ( $closest_index, $closest_distance ) = ( undef, undef );
      for my ( $index, $point ) ( indexed $points->@* ) {
          my $distance = ...;
          ( $closest_index, $closest_distance ) = ( $index, $distance )
              if ! defined $closest_index || $distance < $closest_distance;
      }
      return $closest_index // -1;
  ```

Putting all together, this is my 'traditional' solution: 

```perl
use v5.36;
use builtin qw( indexed );

sub nearest_valid_point( $x, $y, $points ) {
    my ( $closest_index, $closest_distance ) = ( undef, undef );
    for my ( $index, $point ) ( indexed $points->@* ) {
        my $distance = 
            $point->[0] == $x   ? abs( $y - $point->[1] )
            : $point->[1] == $y ? abs( $x - $point->[0] )
            : next;
        ( $closest_index, $closest_distance ) = ( $index, $distance )
            if ! defined $closest_index || $distance < $closest_distance;
    }
    return $closest_index // -1;
}
```

#### The Shorter Solution (using a clever library function)

 Normally it is much easier to use a `min` function than programming a `for` loop for finding a minimum.
So let's see how that can make the code shorter.<br/>
As we have two values to keep (the index and the current closest distance), the normal `min` function from `List::Util` doesn't help here. But there is a `min_by` function in the `List::UtilsBy` CPAN module (also in `List::AllUtils`) that works like this:

> ##### min_by
>
> ```
>     $optimal = min_by { KEYFUNC } @vals
>     @optimal = min_by { KEYFUNC } @vals       
> ```
>
> [...] returns values which give the numerically smallest result from the key function.

We can provide the indexes of the 'valid' points, and let the `KEYFUNC` calculate the Manhattan distance as the minimum criterion.<br/>And for getting those 'valid' indexes, we can use `grep` to filter them from the original list of points.

Since we are separating the filtering from the distance calculation, we cannot take the shortcuts that ignore one dimension if the x- or y-coordinates equal `$x` or `$y` here. We must perform the standard Manhattan distance calculation, which includes both dimensions.

But still, this results in a much shorter solution, rendering both the `for` loop and the two-variable minimum calculation code unnecessary:

```perl   
use v5.36;
use List::UtilsBy qw( min_by );

sub nearest_valid_pointXXX( $x, $y, $points ) {
    my $closest_index =
        min_by { abs( $points->[$_][0] - $x ) + abs( $points->[$_][1] - $y ) }
            grep $points->[$_][0] == $x || $points->[$_][1] == $y,
                keys $points->@*;
    return $closest_index // -1;
}
```

Less code is good code!

#### **Thank you for the challenge!**
