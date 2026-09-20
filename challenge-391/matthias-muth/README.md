# Arrays of Numbers, Arrays of Boxes
**Challenge 391 solutions in Perl by Matthias Muth**

## Task 1: Array Median

> You are given two sorted arrays.<br/>
> Write a script to merge the two given sorted arrays and return the median of the merged array.
>
> **Example 1**
>
> ```text
> Input: @arr1 = (2), @arr2 = (4)
> Output: 3.0
> 
> Merged array: (2,4)
> Median: (2+4)/2 => 3
> ```
>
> **Example 2**
>
> ```text
> Input: @arr1 = (1,2,3), @arr2 = (7,8,9,10)
> Output: 7.0
> 
> Merged array: (1,2,3,7,8,9,10)
> Length of merged array is 7, the 4th element is 7.
> ```
>
> **Example 3**
>
> ```text
> Input: @arr1 = (), @arr2 = (10,20,30,40)
> Output: 25.0
> 
> Merged array: (10,20,30,40)
> Median: (20+30)/2 => 25
> ```
>
> **Example 4**
>
> ```text
> Input: @arr1 = (100), @arr2 = (1,2,3,4,5,6,7)
> Output: 4.5
> 
> Merged array: (1,2,3,4,5,6,7,100)
> Median: (4+5)/2 => 4.5
> ```
>
> **Example 5**
>
> ```text
> Input: @arr1 = (1,2,2), @arr2 = (2,2,3)
> Output: 2.0
> 
> Merged array: (1,2,2,2,2,3)
> Median: (2+2)/2 => 2
> ```

From [Wikipedia](https://en.wikipedia.org/wiki/Median):

> The median of a finite list of numbers is the middle number when the numbers are arranged in order from smallest to greatest. [...]
>
> If the data set has an even number of observations, there is no distinct middle value and the median is usually defined to be the [arithmetic mean](https://en.wikipedia.org/wiki/Arithmetic_mean) of the two middle values.

So the solution is to first sort the numbers numerically.

As we have two arrays of input that are already sorted, we could merge the two arrays directly. But instead of implementing a subroutine to merge two sorted arrays, I kept it short and just used `sort` to sort all the combined values again.

Next, we can return either the arithmetic mean of the two middle values if the number of values in the sorted array is even, or the value in the middle of the array if the number of values is odd.

All of this can be put in two statements:

```perl
use v5.36;

sub array_median( $arr1, $arr2 ) {
    my @all = sort { $a <=> $b } ( $arr1->@*, $arr2->@* );
    return @all % 2 == 0
        ? ( $all[ @all / 2 - 1 ] + $all[ @all / 2 ] ) / 2
        : $all[ int( @all / 2 ) ];
}
```

Some things to note regarding Perl idioms:

* `use v5.36;` is short for a lot of good things:

  * it enables `strict`  and `warnings`, without which no-one should write Perl programs (earlier Perl versions turned on  `strict` (from v5.12), but not `warnings`.)
  * it enables subroutine signatures,
  * it enables a number of other features introduced in earlier Perl versions, in particular the postfix dereference syntax (`$aref->@*`, etc.) introduced in v5.20, which I prefer to the traditional `@{...}`.

  I wouldn't call this *Modern Perl* anymore, it's just *Current Perl*.

* `sort { $a <=> $b } ...`
  `sort` sorts lexicographically by default, so we explicitly give a comparison code block for sorting numerically. 

* `$arr1` and `$arr2` are *arrayrefs*, and `$arr1->@*` and `$arr2->@*` give us the values in those arrays.

* In `@all / 2`, the `@all` array is used in scalar context, where an array evaluates to its number of elements rather than its contents.

* When we know that `@all` has an *odd* number of values, `@all / 2` has a `.5` fractional part, so I made the conversation to an integer explicit with  `int( @all / 2 )` when using it as an index. It would be perfectly fine to leave out the `int( ... )`, because array indices are converted to integers anyway.
  
  I could also have used `$#all / 2` as the index, with `$#all` being the index of the last element, to avoid the `- 1` subtraction. I find `@all / 2` more connected to the definition of the median, though.

## Task 2: Arrange Box

> You are given an array of box dimensions.<br/>
> Write a script to determine the maximum number of these boxes that can fit inside each other in a single stack. For a box to fit inside another, it must be smaller in both dimensions.
>
> **Example 1**
>
> ```text
> Input: @boxes = ([1, 3], [3, 5], [6, 8], [2, 4])
> Output: 4
>
> Sort by width ascending: ([1, 3], [2, 4], [3, 5], [6, 8])
> Extract heights: [3, 4, 5, 8]
> [1, 3] -> [2, 4] -> [3, 5] -> [6, 8]
> ```
>
> **Example 2**
>
> ```text
> Input: @boxes = ([4, 5], [4, 6], [6, 7], [2, 3], [4, 3])
> Output: 3
>
> Sort by width ascending: ([2, 3], [4, 6], [4, 5], [4, 3], [6, 7])
> Extract heights: (3, 6, 5, 3, 7)
> [2, 3] -> [4, 5] -> [6, 7]
> ```
>
> **Example 3**
>
> ```text
> Input: @boxes = ([5, 5], [5, 5], [5, 5])
> Output: 1
>
> Sort by width ascending: ([5, 5], [5, 5], [5, 5])
> Extract heights: (5, 5, 5)
> [5, 5]
> ```
>
> **Example 4**
>
> ```text
> Input: @boxes = ([2, 100], [3, 200], [4, 300], [5, 50], [5, 400])
> Output: 4
>
> Sort by width ascending: ([2, 100], [3, 200], [4, 300], [5, 400], [5, 50])
> Extract heights: (100, 200, 300, 400, 50)
> [2, 100] -> [3, 200] -> [4, 300] -> [5, 400]
> ```
>
> **Example 5**
>
> ```text
> Input: @boxes = ([10, 20], [15, 10], [20, 30], [12, 18], [16, 25])
> Output: 3
>
> Sort by width ascending: ([10, 20], [12, 18], [15, 10], [16, 25], [20, 30])
> Extract heights: (20, 18, 10, 25, 30)
> [15, 10] -> [16, 25] -> [20, 30]
> ```

#### Algorithm:

My algorithm works like this:

We can imagine navigating in a graph where each box is a vertex, and edges lead to all larger boxes that can contain it.

Since every edge leads from a smaller box to a larger one, the graph is directed and acyclic.

But it is not a tree, since there can be several 'starting boxes' that cannot contain each other, so there is no single 'root'. 

Also, several different smaller boxes can fit into the same larger box, which means that a vertex can have several edges leading *into* it.

First, some definitions:

* A 'stack' is a sequence of boxes that fit into each other, from smallest to largest.
* In any stack, the sequence of the boxes' indexes in the original array is the stack's 'path'.

We are interested in finding the longest possible path length.

* First, sort all boxes by width, from smallest to largest (no need to sort by height for this algorithm).

* Keep a 'longest path length seen so far to reach this box' attribute for every box, calling it the box's 'path length' for short.
  The 'path length' is initialized to `1` for all boxes, because every box can form a minimal stack with only itself as the single box in the stack.
  The path length will be updated in the further steps.
* Look at the first box in the sorted array. This is our 'current' box.
  It has a path length of 1 from the initialization.
* Loop over all 'other' boxes to the right of the current box, to find boxes that are larger than the current box in both dimensions (there cannot be any larger boxes to the left of the current box).
* If the other box is larger than the current box, it can contain the current box, together with all the boxes that might be stacked inside it already.
  The path length of this combined (virtual) stack is the existing path length of the current box, plus 1 for the other box.
* If the combined path length is larger than what the other box already has as 'path length', it is updated to the new value.
* Repeat the above steps for all boxes.
* In the end, return the largest 'path length' attribute of all boxes, or zero if there are no boxes at all.

#### Implementation:

The implementation is straightforward. It consists of two preparation steps: sorting the boxes by width, and initializing the path lengths to 1, in a separate array using the same indexes as the sorted array of boxes.

Sorting by width is enough to achieve a topological ordering: any box that can contain the current box must occur to its right. There is no need to sort by height at this time because the height comparison is still checked explicitly later.

Then, we have a nested loop for the 'current' box and the 'other' box.

Within the inner loop, the two conditions of the current box fitting into the other box and the combined path length being greater than the existing path length can be put into the same statement. If the conditions are met, the other box's path length is updated.

In the end, we return the maximum path length of all boxes.

This is the whole solution:

```perl
use v5.36;

use List::Util qw( max );

sub arrange_box ( @boxes ) {
    @boxes = sort { $a->[0] <=> $b->[0] || $a->[1] <=> $b->[1] } @boxes;
    my @path_lengths = ( 1 ) x @boxes;
    for my $current ( keys @boxes ) {
        for my $other ( $current + 1 .. $#boxes ) {
            $path_lengths[$other] = $path_lengths[$current] + 1
                if $boxes[$other][0] > $boxes[$current][0]
                    && $boxes[$other][1] > $boxes[$current][1]
                    && $path_lengths[$current] + 1 > $path_lengths[$other];
        }
    }
    return max( @path_lengths ) // 0;
}
```

The number of iterations in the nested loop is $n (n-1)/2$, so the runtime complexity is $O(n^2)$.

But as the operations within the loop body are not particularly complicated, it still finds the solution for 1000 boxes in under one second on my machine.



#### **Thank you for the challenge!**
