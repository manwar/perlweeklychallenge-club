# Perl Magic Games

**Challenge 268 solutions in Perl by Matthias Muth**

## Task 1: Magic Number

> You are given two arrays of integers of same size, @x and @y.<br/>
> Write a script to find the magic number that when added to each elements of one of the array gives the second array. Elements order is not important.<br/>
> <br/>
> Example 1<br/>
> Input: @x = (3, 7, 5)<br/>
>                @y = (9, 5, 7)<br/>
> Output: 2<br/>
> The magic number is 2.<br/>
> @x = (3, 7, 5)<br/>
>    	\+ 2  2  2<br/>
> @y = (5, 9, 7)<br/>
> <br/>
> Example 2<br/>
> Input: @x = (1, 2, 1)<br/>
>                @y = (5, 4, 4)<br/>
> Output: 3<br/>
> The magic number is 3.<br/>
> @x = (1, 2, 1)<br/>
>              \+  3  3  3<br/>
> @y = (5, 4, 4)<br/>
> <br/>
> Example 3<br/>
> Input: @x = (2)<br/>
>             @y = (5)<br/>
> Output: 3<br/>

If we only could be sure that once we have a 'magic number', it will be the correct one for all the numbers in the two arrays! In that case, we would be done if we simply computed the difference of the two lowest numbers in each array!<br/>Very easy:
```perl
use v5.36;

use List::Util qw( min );

sub magic_number_short( $x, $y ) {
    return min( $y->@* ) - min( $x->@* );
}
```

This works for all examples given, so there it is: a quite short solution for this task.

But we all know that life can be hard, and input data can be not what we expect.<br/>So actually we should do some checking, and only return the magic number if it's the correct difference for *all* the numbers in the two arrays. 

So the longer solution is to sort the two arrays, and to compare all differences between corresponding pairs of numbers.

To compute those differences, I use the `zip` function (from `List::Util`) to join the two sorted arrays. This results in a list of references to two-element arrays, each containing one number from the first and one number from the second array. I then use `map` to turn the two numbers from each entry into their difference.

Once we have all differences, we can check whether all of them are the same as the first one (using `all`, also from `List::Util`), and if so, return this as our 'magic' number. If they are not all the same, we return `undef`, kind of 'extending the specification' because we are not told what should happen in that case.

We also should deal with the edge case of empty input arrays, and also make sure that the two input arrays have the same number of elements. So we prepend a small input check, for not running into any 'undefined value' warnings in those cases.

I think the result still looks quite reasonable:

```perl
use v5.36;

sub magic_number( $x, $y ) {
    @$x && ( @$x == @$y )
        or return undef;
    my @diffs = map $_->[1] - $_->[0],
        zip [ sort { $a <=> $b } $x->@* ],
            [ sort { $a <=> $b } $y->@* ];
    return
        ( all { $_ == $diffs[0] } @diffs[1..$#diffs] )
        ? $diffs[0]
        : undef;
}
```

## Task 2: Number Game

> You are given an array of integers, @ints, with even number of elements.<br/>
> Write a script to create a new array made up of elements of the given array. Pick the two smallest integers and add it to new array in decreasing order i.e. high to low. Keep doing until the given array is empty.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (2, 5, 3, 4)<br/>
> Output: (3, 2, 5, 4)<br/>
> Round 1: we picked (2, 3) and push it to the new array (3, 2)<br/>
> Round 2: we picked the remaining (4, 5) and push it to the new array (5, 4)<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (9, 4, 1, 3, 6, 4, 6, 1)<br/>
> Output: (1, 1, 4, 3, 6, 4, 9, 6)<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (1, 2, 2, 3)<br/>
> Output: (2, 1, 3, 2)<br/>

This is one of the tasks where a bit of thinking about what really happens helps to find a nice and easy solution:

The instructions basically suggest to use a loop, where inside the loop we find the two smallest numbers in the array,
remove them from the input array
and add them -- in reversed order -- into the output array.

I don't like searching within a loop body.<br/>
Even if we might not run into a purely quadratic big O complexity just by searching
(because we shorten the array after each iteration),
destroying the input array just for that reason is not really elegant,
and even if it takes only split-micro-seconds,
I don't like wasting computing power for something like that.

The good thing is that we can achieve the same result
by simply sorting the array numerically (with a typical complexity of $`O(n\log n)`$),
and then flipping each pair of adjacent numbers
(in one simple additional pass).<br/>
Ah, much better ;-)

We even can do this 'on the fly',
feeding the `sort` output into the `pairs` function (from `List::Util`),
which splits the numbers into small two-element arrays,
and then flipping the two numbers using `reverse` on each of those mini-arrays, using a `map` code block.

Looks 'perlish' to me, and hey, another one-liner! Who would have guessed!   

```perl
use v5.36;

use List::Util qw( pairs );

sub number_game( @ints ) {
    return map { reverse $_->@* } pairs sort { $a <=> $b } @ints;
}
```

#### **Thank you for the challenge!**

