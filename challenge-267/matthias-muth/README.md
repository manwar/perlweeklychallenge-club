# Signs Count!
**Challenge 267 solutions in Perl by Matthias Muth**

## Task 1: Product Sign

> You are given an array of @ints.<br/>
> Write a script to find the sign of product of all integers in the given array. The sign is 1 if the product is positive, -1 if the product is negative and 0 if product is zero.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (-1, -2, -3, -4, 3, 2, 1)<br/>
> Output: 1<br/>
> The product -1 x -2 x -3 x -4 x 3 x 2 x 1 => 144 > 0<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (1, 2, 0, -2, -1)<br/>
> Output: 0<br/>
> The product 1 x 2 x 0 x -2 x -1 => 0<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (-1, -1, 1, -1, 2)<br/>
> Output: -1<br/>
> The product -1 x -1 x 1 x -1 x 2 => -2 < 0<br/>

Probably one of the shortest Weekly Challenge solutions that I ever wrote!<br/>
Some considerations first:

- Multiplying all the numbers in the list might cause an integer overflow.<br/>
  So let's better to multiply only the 'signs' of the numbers,
  like `-1` for negative numbers, `0` for zero and `+1` for positive numbers.

- There is the `sign` function from `Math::Utils`
  that returns the sign of a number like that.

- But we can also use Perl's 'spaceship operator' `<=>` instead.<br/>
  It returns `-1`, `0`, or `1` depending on whether the left argument is
  numerically less  than, equal to, or greater than the right argument.<br/>
  So by comparing against zero, like<br/>
  
    `$n <=> 0`
  
  we get the number's sign just the same.<br/>
  This reduces the startup cost because we don't need to load that module,
  and it avoids the function call overhead.

So we map the integers to their signs,
and let the `product` function from `List::Util`
do the work of multiplying them.

```perl
use v5.36;

use List::Util qw( product );

sub product_sign( @ints ) {
    return product map $_ <=> 0, @ints;
}
```

There is one optimization that I could consider for large lists
that also have a probability of containing zero values:<br/>
If there is at least one zero in the list, the product will always be zero, too.
So we can shortcut the result once we encounter the first zero.

We even can return from right inside the map code block once we see a zero sign.
And this can even be a bit 'elegant'
if we chain the `return` with a logical `or`.
The `return` will be executed only if the first expression (the sign)
is 'logically false' (i.e., zero in our case),
and if not, the first expression (the sign) is used.
```perl
sub product_sign( @ints ) {
    return product map { $_ <=> 0 or return 0 } @ints;
}
```
Still nice and short!

## Task 2: Line Counts

> You are given a string, \$str, and a 26-items array @widths containing the width of each character from a to z.<br/>
> Write a script to find out the number of lines and the width of the last line needed to display the given string, assuming you can only fit 100 width units on a line.<br/>
> <br/>
> Example 1<br/>
> Input: \$str = "abcdefghijklmnopqrstuvwxyz"<br/>
>        @widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)<br/>
> Output: (3, 60)<br/>
> Line 1: abcdefghij (100 pixels)<br/>
> Line 2: klmnopqrst (100 pixels)<br/>
> Line 3: uvwxyz (60 pixels)<br/>
> <br/>
> Example 2<br/>
> Input: \$str = "bbbcccdddaaa"<br/>
>        @widths = (4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)<br/>
> Output: (2, 4)<br/>
> Line 1: bbbcccdddaa (98 pixels)<br/>
> Line 2: a (4 pixels)<br/>

This part needs a bit more of an algorithm, so I will be a bit more verbose to make the solution readable.

First thing is to initialize the variables that will be returned in the end.<br/>
The number of lines reflects the lines *including* the one we will be working on
(the 'current line'), so we start with `1`.
But actually we need to return zero lines if the input `$str` is empty,
so we consider that in the initialization.<br/>
The current line width starts with zero, as we haven't added anything yet.

Then we loop over all letters in `$str`.
For each letter, we get its width from the input array,
using its distance from the letter `'a'` as the the index into that array.

If adding the letter's width would exceed the maximum width of 100,
we increment the number of lines and reset the current line width.
Then we add the letter's width.

When we exit the loop, we can directly return the result.

Actually I guess my explanations did not add a lot that could not be
easily understood from reading the code.
Or at least I hope...

```perl
use v5.36;

sub line_counts( $str, $widths ) {
    my ( $n_lines, $current_line_width ) = ( $str ne "" || 0, 0 );
    for ( split "", $str ) {
        my $char_width = $widths->[ ord( $_ ) - ord( 'a' ) ];
        if ( $current_line_width + $char_width > 100 ) {
            ++$n_lines;
            $current_line_width = 0;
        }
        $current_line_width += $char_width;
    }
    return ( $n_lines, $current_line_width );
}
```

#### **Thank you for the challenge!**
