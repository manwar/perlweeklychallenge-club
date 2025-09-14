# Higher and Higher

**Challenge 338 solutions in Perl by Matthias Muth**

## Task 1: Highest Row

> You are given a m x n matrix.<br/>
> Write a script to find the highest row sum in the given matrix.
>
> **Example 1**
>
> ```text
> Input: @matrix = ([4,  4, 4, 4],
>                   [10, 0, 0, 0],
>                   [2,  2, 2, 9])
> Output: 16
>
> Row 1: 4  + 4 + 4 + 4 => 16
> Row 2: 10 + 0 + 0 + 0 => 10
> Row 3: 2  + 2 + 2 + 9 => 15
> ```
>
> **Example 2**
>
> ```text
> Input: @matrix = ([1, 5],
>                   [7, 3],
>                   [3, 5])
> Output: 10
> ```
>
> **Example 3**
>
> ```text
> Input: @matrix = ([1, 2, 3],
>                   [3, 2, 1])
> Output: 6
> ```
>
> **Example 4**
>
> ```text
> Input: @matrix = ([2, 8, 7],
>                   [7, 1, 3],
>                   [1, 9, 5])
> Output: 17
> ```
>
> **Example 5**
>
> ```text
> Input: @matrix = ([10, 20,  30],
>                   [5,  5,   5],
>                   [0,  100, 0],
>                   [25, 25,  25])
> Output: 100
> ```

Nothing spectacular about this solution.

For every the row of the matrix, compute the `sum` of the elements in that row.
Using `map` for this,
because I find it so much more expressive and concise than a `for` loop.

As another benefit of `map`,
we can also feed the resulting set of row sums
directly into `max` as parameters,
which directly gives us our return value.  

So why not use a one-liner if we can?

```perl
use v5.36;
use List::Util qw( sum max );

sub highest_row( $matrix ) {
    return max( map sum( $_->@* ), $matrix->@* );
}
```

## Task 2: Max Distance

> You are given two integer arrays, @arr1 and @arr2.<br/>
> Write a script to find the maximum difference between any pair of values from both arrays.
>
> **Example 1**
>
> ```text
> Input: @arr1 = (4, 5, 7)
>        @arr2 = (9, 1, 3, 4)
> Output: 6
>
> With element $arr1[0] = 4
> | 4 - 9 | = 5
> | 4 - 1 | = 3
> | 4 - 3 | = 1
> | 4 - 4 | = 0
> max distance = 5
>
> With element $arr1[1] = 5
> | 5 - 9 | = 4
> | 5 - 1 | = 4
> | 5 - 3 | = 2
> | 5 - 4 | = 1
> max distance = 4
>
> With element $arr1[2] = 7
> | 7 - 9 | = 2
> | 7 - 1 | = 6
> | 7 - 3 | = 4
> | 7 - 4 | = 4
> max distance = 6
>
> max (5, 6, 6) = 6
> ```
>
> **Example 2**
>
> ```text
> Input: @arr1 = (2, 3, 5, 4)
>        @arr2 = (3, 2, 5, 5, 8, 7)
> Output: 6
>
> With element $arr1[0] = 2
> | 2 - 3 | = 1
> | 2 - 2 | = 0
> | 2 - 5 | = 3
> | 2 - 5 | = 3
> | 2 - 8 | = 6
> | 2 - 7 | = 5
> max distance = 6
>
> With element $arr1[1] = 3
> | 3 - 3 | = 0
> | 3 - 2 | = 1
> | 3 - 5 | = 2
> | 3 - 5 | = 2
> | 3 - 8 | = 5
> | 3 - 7 | = 4
> max distance = 5
>
> With element $arr1[2] = 5
> | 5 - 3 | = 2
> | 5 - 2 | = 3
> | 5 - 5 | = 0
> | 5 - 5 | = 0
> | 5 - 8 | = 3
> | 5 - 7 | = 2
> max distance = 3
>
> With element $arr1[3] = 4
> | 4 - 3 | = 1
> | 4 - 2 | = 2
> | 4 - 5 | = 1
> | 4 - 5 | = 1
> | 4 - 8 | = 4
> | 4 - 7 | = 3
> max distance = 4
>
> max (5, 6, 3, 4) = 6
> ```
>
> **Example 3**
>
> ```text
> Input: @arr1 = (2, 1, 11, 3)
>        @arr2 = (2, 5, 10, 2)
> Output: 9
>
> With element $arr1[0] = 2
> | 2 - 2  | = 0
> | 2 - 5  | = 3
> | 2 - 10 | = 8
> | 2 - 2  | = 0
> max distance = 8
>
> With element $arr1[1] = 1
> | 1 - 2  | = 1
> | 1 - 5  | = 4
> | 1 - 10 | = 9
> | 1 - 2  | = 1
> max distance = 9
>
> With element $arr1[2] = 11
> | 11 - 2  | = 9
> | 11 - 5  | = 6
> | 11 - 10 | = 1
> | 11 - 2  | = 9
> max distance = 9
>
> With element $arr1[3] = 3
> | 3 - 2  | = 1
> | 3 - 5  | = 2
> | 3 - 10 | = 7
> | 3 - 2  | = 1
> max distance = 7
>
> max (8, 9, 9, 7) = 9
> ```
>
> **Example 4**
>
> ```text
> Input: @arr1 = (1, 2, 3)
>        @arr2 = (3, 2, 1)
> Output: 2
>
> With element $arr1[0] = 1
> | 1 - 3 | = 2
> | 1 - 2 | = 1
> | 1 - 1 | = 0
> max distance = 2
>
> With element $arr1[1] = 2
> | 2 - 3 | = 1
> | 2 - 2 | = 0
> | 2 - 1 | = 1
> max distance = 1
>
> With element $arr1[2] = 3
> | 3 - 3 | = 0
> | 3 - 2 | = 1
> | 3 - 1 | = 2
> max distance = 2
>
> max (2, 1, 2) = 2
> ```
>
> **Example 5**
>
> ```text
> Input: @arr1 = (1, 0, 2, 3)
>        @arr2 = (5, 0)
> Output: 5
>
> With element $arr1[0] = 1
> | 1 - 5 | = 4
> | 1 - 0 | = 1
> max distance = 4
>
> With element $arr1[1] = 0
> | 0 - 5 | = 5
> | 0 - 0 | = 0
> max distance = 5
>
> With element $arr1[2] = 2
> | 2 - 5 | = 3
> | 2 - 0 | = 2
> max distance = 3
>
> With element $arr1[3] = 3
> | 3 - 5 | = 2
> | 3 - 0 | = 3
> max distance = 3
>
> max (4, 5, 3, 3) = 5
> ```

A lot of explicit examples for a simple task.
But the more examples the better, because the more *tests* the better.

A short reflection tells us that the maximum distance between any two numbers
in the arrays can only be between the lowest number of the first array
and the highest one of the second, or vice versa.

So the easiest way to solve this is not to try each and every combination of numbers
of the two arrays,
but to first extract the lowest and highest number of each array,
and then return the larger difference.

There is a function called `minmax`
that returns the minimum *and* the maximum of the parameter list
at the same time (available from `List::SomeUtils` on CPAN).<br/>
`minmax` can optimize the performance a bit,
because instead of running through each arrays two times,
using $2\cdot(n-1) = 2n -2$ comparisons,
we only need $\frac{3}{2}n - 2$ comparisons.

Whether that's worth it or not,
I think it also makes the code a bit more readable:

```perl
use v5.36;
use List::SomeUtils qw( minmax );
use List::Util qw( max );

sub max_distance( $arr1, $arr2 ) {
    my ( $arr1_min, $arr1_max ) = minmax $arr1->@*;
    my ( $arr2_min, $arr2_max ) = minmax $arr2->@*;
    return max( $arr2_max - $arr1_min, $arr1_max - $arr2_min );
}
```

#### **Thank you for the challenge!**
