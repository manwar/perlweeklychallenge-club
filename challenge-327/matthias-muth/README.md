# Modern Perl's Victory

**Challenge 326 solutions in Perl by Matthias Muth**

## Task 1: Day of the Year

> You are given a date in the format YYYY-MM-DD.<br/>
> Write a script to find day number of the year that the given date represent.
>
> **Example 1**
>
> ```text
> Input: $date = '2025-02-02'
> Output: 33
>The 2nd Feb, 2025 is the 33rd day of the year.
> ```
>
> **Example 2**
>
> ```text
>Input: $date = '2025-04-10'
> Output: 100
> ```
> 
>**Example 3**
> 
>```text
> Input: $date = '2025-09-07'
>Output: 250
> ```

It's good to have our superb set of on-board tools — the core modules. For this task, `Time::Piece` helps us to create a one-line solution.

The dates we receive as input are ISO date strings. The `strptime` function can easily convert that into a `Time::Piece` object using the `'%F'` format. We can then use the `day_of_year` method (or `yday` for short) to return the day of the year. We just need to add 1 because the result is zero-based, and we want the day numbered from 1 for January 1st.

As simple as this:

```perl
use v5.36;
use Time::Piece;

sub day_of_the_year( $date ) {
    return Time::Piece->strptime( $date, "%F" )->day_of_year + 1;
}
```

## Task 2: Decompressed List

> You are given an array of positive integers having even elements.<br/>
> Write a script to to return the decompress list. To decompress, pick adjacent pair (i, j) and replace it with j, i times.
>
> **Example 1**
>
> ```text
> Input: @ints = (1, 3, 2, 4)
> Output: (3, 4, 4)
>
> Pair 1: (1, 3) => 3 one time  => (3)
> Pair 2: (2, 4) => 4 two times => (4, 4)
>```
> 
>**Example 2**
> 
>```text
> Input: @ints = (1, 1, 2, 2)
> Output: (1, 2, 2)
> 
>Pair 1: (1, 1) => 1 one time  => (1)
> Pair 2: (2, 2) => 2 two times => (2, 2)
> ```
>
> **Example 3**
>
> ```text
>Input: @ints = (3, 1, 3, 2)
> Output: (1, 1, 1, 2, 2, 2)
> 
> Pair 1: (3, 1) => 1 three times => (1, 1, 1)
>Pair 2: (3, 2) => 2 three times => (2, 2, 2)
> ```

This task is about walking through an array in steps of 2 elements.<br/>
I will compare three different implementations:

* 'Conventional' :<br/>
  Using a C-style `for(;;)` loop to increment the index by 2 for each iteration.<br/>A bit old-style, maybe, and for sure a bit cumbersome that we then need to use the index itself *and* (index + 1) for the pair of elements.
* 'Elegant':<br/>Using `pairmap` to walk through the elements in pairs makes it a very elegant one-liner.
* 'Modern':<br/>Since Perl 5.36 you can use a *list* of lexical variables as loop variables.<br/>
  This makes the loop very intuitive to write (and to read and understand).<br/>And wait to see the benchmark results!

All my solutions are based on
```perl
use v5.36;
```
to get all kinds of good things, like `use strict`,  `use warnings`,  and subroutine signatures, which I love.<br/>
And all solutions use the Perl `x` operator to repeat each element the given number of  times, like `( <element> ) x <times>`.

##### Conventional (C-style `for` loop)

This is my solution using the C-style, three-statement `for` loop.<br/>
As we loop over the index, we need to do the index dereferencing ourselves.

```perl
sub decompressed_list_c_style_for( @ints ) {
    my @decompressed;
    for ( my $i = 0; $i <= $#ints; $i += 2 ) {
        push @decompressed, ( $ints[ $i + 1 ] ) x $ints[ $i ];
    }
    return @decompressed;
}
```

It works, but it's a bit clumsy.

##### Elegant (`pairmap`)

Using `pairmap`from the `List::Util` core module results in what probably is the shortest and clearest solution:

```perl
use List::Util qw( pairmap );

sub decompressed_list_pairmap( @ints ) {
    return pairmap { ( $b ) x $a } @ints;
}
```

It assigns each pair of values to the `$a` and `$b` special variables and calls its code block. It then returns the combined list of all code block results.<br/>Very nice!

##### Modern (multi-value `for` loop)

A multi-value `for` loop walks through several elements at once, assigning them to a list of lexical variables (doing aliasing, actually).<br/>We can use those variables directly to build the result. As we use the elements themselves, not the indexes, there's no need to do any dereferencing.

```perl
sub decompressed_list_multi_value_for( @ints ) {
    my @decompressed;
    for my ( $n, $i ) ( @ints ) {
        push @decompressed, ( $i ) x $n;
    }
    return @decompressed;
}
```

Compared to the C-style `for` loop, this saves a lot of writing and can avoid typical typo errors.<br/>And compared to the `pairmap` solution, it does a lot of things efficiently 'under the hood': It avoids the subroutine call with its need to copy parameters, and I guess that error checking and the assignments to the `$a` and `$b` variables are more expensive than aliasing the lexical variables.

Let's see what the benchmark says:

##### Benchmark

I ran a little benchmark:

```perl
cmpthese -3, {
    c_style_for     => sub { decompressed_list_c_style_for( 3, 1, 3, 2 ); },
    pairmap         => sub { decompressed_list_pairmap( 3, 1, 3, 2 ); },
    multi_value_for => sub { decompressed_list_multi_value_for( 3, 1, 3, 2 ); },
};
```

with results that astonished me:

```text
                     Rate         pairmap     c_style_for multi_value_for
pairmap          999261/s              --            -22%            -41%
c_style_for     1288603/s             29%              --            -23%
multi_value_for 1679823/s             68%             30%              --
```

The 'modern' solution with the multi-value `for` loop beats all the others!

The `pairmap` solution may be the most beautiful, but it definitely isn't the best performing one.

And there's no good reason at all to use the more complicated conventional C-style `for` loop.

Lessons learned!

#### **Thank you for the challenge!**
