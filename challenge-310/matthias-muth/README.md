# Mini Mini

**Challenge 309 solutions in Perl by Matthias Muth**

## Task 1: Min Gap

> You are given an array of integers, @ints, increasing order.<br/>
> Write a script to return the element before which you find the smallest gap.
>
> **Example 1**
>
> ```text
> Input: @ints = (2, 8, 10, 11, 15)
> Output: 11
>
>  8 - 2  => 6
> 10 - 8  => 2
> 11 - 10 => 1
> 15 - 11 => 4
>
> 11 is where we found the min gap.
> ```
>
> **Example 2**
>
> ```text
> Input: @ints = (1, 5, 6, 7, 14)
> Output: 6
>
>  5 - 1 => 4
>  6 - 5 => 1
>  7 - 6 => 1
> 14 - 7 => 7
>
> 6 and 7 where we found the min gap, so we pick the first instance.
> ```
>
> **Example 3**
>
> ```text
> Input: @ints = (8, 20, 25, 28)
> Output: 28
>
>  8 - 20 => 14
> 25 - 20 => 5
> 28 - 25 => 3
>
> 28 is where we found the min gap.
> ```

I translated each step of finding the result into one line of Perl code.<br/>
I make use of the `min` function from `List::Util`,
and of the `slide` and `first_index` functions from `List::MoreUtils`.<br/>
These are the steps:

* Create an array containing the gaps between the numbers in `@ints`.<br/>
I use the `slide` function for that.
It takes a code block and a list as parameters.
It walks through the list of numbers, assigning each number and its next neighbor to `$a` and `$b`,
and puts the result of the code block into the resulting list.<br/>
For us, the code block determines the 'gap' between `$b` and `$a`:
  ```perl
      my @gaps = slide { $b - $a } @ints;
  ```
  
* Find the smallest gap.<br/>Using `min` to get the minimum 'gap' value:
  ```perl
      my $smallest_gap = min( @gaps );
  ```
  
* Find the *index* of the smallest gap in the `@gap` array,
  so that we can later look up the element before which that gap was found.<br/>
  The `first_index` function does this perfectly:

  ```perl
      my $index = first_index { $_ == $smallest_gap } @gaps;
  ```

* Now we only need to return the value from the original array.<br/>
  The first entry in the `@gaps` array corresponds to the second entry in the original `@ints` array,
  so we need to add one to the index that we found:
  ```perl
      return $ints[ $index + 1 ];
  ```

The whole implementation is this:
```perl
use v5.36;

use List::Util qw( min );
use List::MoreUtils qw( slide first_index );

sub min_gap( @ints ) {
    my @gaps = slide { $b - $a } @ints;
    my $smallest_gap = min( @gaps );
    my $index = first_index { $_ == $smallest_gap } @gaps;
    return $ints[ $index + 1 ];
}
```

Maybe one could gain some efficiency by avoiding to walk through the `@gaps` array twice,
once for finding the minimum,
then once again to find the position where it was found.<br/>
But I like the clearness of the solution.

## Task 2: Min Diff

> You are given an array of integers, @ints.<br/>
> Write a script to find the minimum difference between any two elements.
>
> **Example 1**
>
> ```text
> Input: @ints = (1, 5, 8, 9)
> Output: 1
>
> 1, 5 => 5 - 1 => 4
> 1, 8 => 8 - 1 => 7
> 1, 9 => 9 - 1 => 8
> 5, 8 => 8 - 5 => 3
> 5, 9 => 9 - 5 => 4
> 8, 9 => 9 - 8 => 1
> ```
>
> **Example 2**
>
> ```text
> Input: @ints = (9, 4, 1, 7)
> Output: 2
>
> 9, 4 => 9 - 4 => 5
> 9, 1 => 9 - 1 => 8
> 9, 7 => 9 - 7 => 2
> 4, 1 => 4 - 1 => 3
> 4, 7 => 7 - 4 => 3
> 1, 7 => 7 - 1 => 6
> ```

Very similar to the first task, but here, we need a different strategy.<br/>
Actually, we need to compare every number to every other number,
so in theory the complexity is quadratic.

But we can avoid that!

**The smallest difference between two numbers will always be
between two numbers that are next to each other when all the numbers are sorted.**

That means that when we first sort the numbers,
we can then simply 'find the smallest gap', just like in the first task.
Even easier than there, because here,
we don't even need to look up any position of where we found the smallest gap.

This way, the second task's implementation is even shorter that the first one's:

```perl
use v5.36;

use List::Util qw( min );
use List::MoreUtils qw( slide );

sub min_diff( @ints ) {
    @ints = sort { $a <=> $b } @ints;
    my @gaps = slide { $b - $a } @ints;
    return min( @gaps );
}
```


#### **Thank you for the challenge!**
