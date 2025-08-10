# Double O Straight (Not Stirred)

**Challenge 333 solutions in Perl by Matthias Muth**

## Task 1: Straight Line

> You are given a list of co-ordinates.<br/>
> Write a script to find out if the given points make a straight line.
>
> **Example 1**
>
> ```text
> Input: @list = ([2, 1], [2, 3], [2, 5])
> Output: true
>```
> 
>**Example 2**
> 
>```text
> Input: @list = ([1, 4], [3, 4], [10, 4])
> Output: true
> ```
>
> **Example 3**
>
> ```text
>Input: @list = ([0, 0], [1, 1], [2, 3])
> Output: false
> ```
> 
>**Example 4**
> 
>```text
> Input: @list = ([1, 1], [1, 1], [1, 1])
>Output: true
> 
> ```
> 
>**Example 5**
> 
>```text
> Input: @list = ([1000000, 1000000], [2000000, 2000000], [3000000, 3000000])
>Output: true
> ```

For all points $p_i = (x_i, y_i)$ to be on the same line, the slope of all connections between the first point $p_0$ and any other point $p_i$ in the list (with $i>0$) has to be the same. The slopes are defined like this:
```math
\left.slope_i = \frac{dy_i}{dx_i} = \frac{ y_i - y_0 }{ x_i - x_0 }\right|_{i>0}
```
To verify that all slopes are equal, we can determine the slope $slope_1$ between the first two points, $p_0$ and $p_1$, and then compare all other slopes $slope_i$ (with $i \ge 2$) to that. The comparison looks like this:

```math
\displaylines{
slope_i = slope_1 \\\\
\frac{dy_i}{dx_i} = \frac{dy_1}{dx_1} \\\\
dy_i \cdot dx_1 = dy_1 \cdot dx_i
}
```

The good thing is that now, we don't have any divisions anymore, so this comparison is defined for whatever coordinates the points have and even for a vertical line. When the points are on a vertical line, the $dx$ values are zero, making both sides of the formula zero. In the product, the $dy$ values then don't really matter anymore. In fact, that corresponds to the fact that on that vertical line, the points' $y$ values really don't matter.

But there is still the special case that *both* $dx$ and $dy$ are $0$. Then, the two points are the same. They are both on *every* line that goes through the first point. In the formula, both sides are zero again, so the slopes are considered 'equal' for this check, which means that two identical points do not affect the overall result.

Thanks to community solutions published in the [*The Weekly Challenge*](https://www.facebook.com/groups/theweeklychallengegroup) and [*The Perl Community*](https://www.facebook.com/groups/perlcommunity) Facebook groups I have realized that identical points in the list can make things go really wrong (thank you, Niels van Dijke and James Curtis-Smith!).

In my solution, the critical point is that if the first two points $p_0$ and $p_1$ are identical, the $(dx_1, dy_1)$ pair will be $(0,0)$. As a consequence, *any* check will succeed and accept any point being on that 'line', which is wrong. So I need to take care that $(dx_1, dy_1)$ is set using a point that *differs* from $p_0$.

Let's transform this into some Perl code:

To save some typing (and probably some typos, too), I created a `dx_dy` function that returns  the $dx$ and $dy$ between two points.

In the main subroutine, I use this to get `( $dx_1, $dy_1 )` from the first two point in the list.

Then, I use  the `all` keyword (available in Perl version 5.42, but `all` from  `List::Util` does the same job), to go through the rest of the points and check the 'is on the same line' condition.

I deal with the 'identical first points in the list' problem right in that loop. If the `( $dx_1, $dy_1 )` initialization from the first two points made it `( 0, 0 )`,  we are still in the phase of finding the first non-identical point to determine a slope (or non-zero vector). The current point's `( $dx, $dy )` will be used as a next try, and the check is assumed to have succeeded.

If all checks succeed, all points are on the same line.

```perl
use v5.42;
use feature 'keyword_all';
no warnings 'experimental::keyword_all';

sub dx_dy( $p1, $p2 ) {
    return ( $p2->[0] - $p1->[0], $p2->[1] - $p1->[1] );
}

sub straight_line( $list ) {
    my ( $dx_1, $dy_1 ) = dx_dy( $list->[0], $list->[1] );
    return all {
        my ( $dx, $dy ) = dx_dy( $list->[0], $list->[$_] );
        $dx_1 == 0 && $dy_1 == 0
            ? do { ( $dx_1, $dy_1 ) = ( $dx, $dy ); true }
            : $dx_1 * $dy == $dy_1 * $dx;
    } 2 .. $list->$#*;
}
```

In Example 4, *all* the points are identical. In this case, `( $dx_1, $dy_1 )` will still be `( 0, 0 )` in the end, because actually there is no line or slope to check. Example 4 expects a `true` result, and my implementation return that. Maybe it's just luck, but it can also be interpreted like 'identical points do not only lie on the same line, but on indefinitely many lines'!

## Task 2: Duplicate Zeros

> You are given an array of integers.<br/>
> Write a script to duplicate each occurrence of zero, shifting the remaining elements to the right. The elements beyond the length of the original array are not written.
>
> **Example 1**
>
> ```text
> Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
> Output: (1, 0, 0, 2, 3, 0, 0, 4)
>
> Each zero is duplicated.
> Elements beyond the original length (like 5 and last 0) are discarded.
>```
> 
>**Example 2**
> 
>```text
> Input: @ints = (1, 2, 3)
> Output: (1, 2, 3)
> 
>No zeros exist, so the array remains unchanged.
> ```
>
> **Example 3**
>
> ```text
>Input: @ints = (1, 2, 3, 0)
> Output: (1, 2, 3, 0)
> ```
> 
>**Example 4**
> 
>```text
> Input: @ints = (0, 0, 1, 2)
>Output: (0, 0, 0, 0)
> ```
> 
> **Example 5**
>
> ```text
>Input: @ints = (1, 2, 0, 3, 4)
> Output: (1, 2, 0, 0, 3)
>```

Let's try to solve this in two different ways:

##### The resource saving one:

Trying to do only what is needed, nothing else. Building up the array containing the results one by one, using a `for` loop to go through the input data, then a `for` loop that loops over just the one element, if it's non-zero, or over two zeros if the element is zero. Return immediately when the array has the needed number of elements.

Looks a bit clumsy, but might be more efficient if we have a large input array with a high number of zeros. But I am not even sure about that, because all the checking and looping is done on the Perl level. 

```perl
use v5.36;

sub duplicate_zeros_loop( @ints ) {
    my @results = ();
    for ( @ints ) {
        for ( $_ || ( 0, 0 ) ) {
            push @results, $_;
            return @results
                if scalar @results == scalar @ints;
        }
    }
}
```

##### The concise one:

Use `map` to map every item into itself, but a zero into two zeros. From the list that this creates, return only the first elements up to the size of the original array, and throw away the rest.

A one-liner!

```perl
sub duplicate_zeros( @ints ) {
    return ( map $_ || ( 0, 0 ), @ints )[0..$#ints];
}
```

And a little benchmark shows that it's around 50% faster! And more than 50% more Perlish for sure! 

#### **Thank you for the challenge!**
