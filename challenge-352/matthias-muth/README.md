# A Special Sack Race

**Challenge 351 solutions in Perl by Matthias Muth**

## Task 1: Special Average

> You are given an array of integers.<br/>
> Write a script to return the average excluding the minimum and maximum of the given array.
>
> **Example 1**
>
> ```text
> Input: @ints = (8000, 5000, 6000, 2000, 3000, 7000)
> Output: 5250
>Min: 2000
> Max: 8000
> Avg: (3000+5000+6000+7000)/4 = 21000/4 = 5250
> ```
> 
>**Example 2**
> 
>```text
> Input: @ints = (100_000, 80_000, 110_000, 90_000)
> Output: 95_000
> Min: 80_000
>Max: 110_000
> Avg: (100_000 + 90_000)/2 = 190_000/2 = 95_000
> ```
> 
> **Example 3**
>
> ```text
>Input: @ints = (2500, 2500, 2500, 2500)
> Output: 0
> Min: 2500
> Max: 2500
>Avg: 0
> ```
> 
> **Example 4**
> 
>```text
> Input: @ints = (2000)
>Output: 0
> Min: 2000
> Max: 2000
> Avg: 0
>```
> 
> **Example 5**
> 
> ```text
>Input: @ints = (1000, 2000, 3000, 4000, 5000, 6000)
> Output: 3500
>Min: 1000
> Max: 6000
> Avg: (2000 + 3000 + 4000 + 5000)/4 = 14000/4 = 3500
> ```

This task is just a little bit tricky because it is easy to misunderstand '*excluding the minimum and maximum of the given array*', thinking it can be done by just ignoring the first and last element of the sorted array, and building the average over two elements less.

And I did misunderstand, and my first approach did NOT work:

```perl
sub special_average( @ints ) {
    @ints = sort { $a <=> $b } @ints;
    return sum0( @ints[ 1 .. $#ints - 1 ] ) / ( @ints - 2 );
}
```

Actually it has another problem, one that is not tested by the examples:

If there are exactly two elements, they will both be ignored. We then compute the average over an empty array. The `sum` function will emit a warning, but worse, dividing by `( @ints - 2 )` will result in a zero division and a runtime error that aborts the program.

Not good.

Lessons learned: First determine the minimum and maximum values, then strip all those elements off, e.g. using `grep`:

```perl
    my ( $min, $max ) = minmax @ints;
    my @stripped = grep $min < $_ < $max, @ints;
```

The `minmax` function comes from `List::MoreUtils`.<br/>
And I am happy to showcase Perl's *chained comparison*, which has been available since Perl 5.32. 

Then, be careful to avoid warnings of empty arrays in the call to `sum`, which is most easily done by using `sum0` instead (imported from `List::Util`, just like `sum`) .

 And for avoiding zero divisions, probably the easiest way is to replace a zero divisor by a `1`, which is easy using the `||` *logical or* operator. We know that the result of the division will be zero anyway because `sum0` of the empty array is zero.

Putting it all together: 

```perl
use v5.36;
use List::MoreUtils qw( minmax );
use List::Util qw( sum0 );

sub special_average( @ints ) {
    my ( $min, $max ) = minmax @ints;
    my @stripped = grep $min < $_ < $max, @ints;
    return sum0( @stripped ) / ( scalar @stripped || 1 );
}
```

## Task 2: Arithmetic Progression

> You are given an array of numbers.<br/>
> Write a script to return true if the given array can be re-arranged to form an arithmetic progression, otherwise return false.<br/>
> A sequence of numbers is called an arithmetic progression if the difference between any two consecutive elements is the same.
>
> **Example 1**
>
> ```text
> Input: @num = (1, 3, 5, 7, 9)
> Output: true
>Already AP with common difference 2.
> ```
> 
>**Example 2**
> 
>```text
> Input: @num = (9, 1, 7, 5, 3)
> Output: true
> The given array re-arranged like (1, 3, 5, 7, 9) with common difference 2.
>```
> 
> **Example 3**
>
> ```text
>Input: @num = (1, 2, 4, 8, 16)
> Output: false
> This is geometric progression and not arithmetic progression.
> ```
>
> **Example 4**
> 
>```text
> Input: @num = (5, -1, 3, 1, -3)
>Output: true
> The given array re-arranged like (-3, -1, 1, 3, 5) with common difference 2.
> ```
> 
>**Example 5**
> 
> ```text
>Input: @num = (1.5, 3, 0, 4.5, 6)
> Output: true
>The given array re-arranged like (0, 1.5, 3, 4.5, 6) with common difference 1.5.
> ```

If the array can be rearranged in the way the task mandates, it will in any case be a sorted array.

That means we 'reverse' the task: sort the array first, and then check whether the difference between each pair of neighboring numbers is the same. The difference can be taken from the first pair of numbers, and then we check whether all the 'hops' from number to number are the same.

This translates directly into Perl code (with the help of `all` from `List::Util`):

```perl
use v5.36;
use List::Util qw( all );

sub arithmetic_progression( @num ) {
    @num = sort { $a <=> $b } @num;
    my $diff = $num[1] - $num[0];
    return all { $num[$_] == ( $num[ $_ - 1 ] + $diff ) } 2..$#num;
}
```

#### **Thank you for the challenge!**
