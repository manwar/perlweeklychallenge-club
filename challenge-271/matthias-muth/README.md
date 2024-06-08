# You are my only ones...
**Challenge 271 solutions in Perl by Matthias Muth**

## Task 1: Maximum Ones

> You are given a `m x n` binary matrix.<br/>
> Write a script to return the row number containing maximum ones, in case of more than one rows then return smallest row number.<br/>

> **Example 1**

>      Input: $matrix = [ [0, 1],
>                         [1, 0],
>                       ]
>     Output: 1
>     Row 1 and Row 2 have the same number of ones, so return row 1.

> **Example 2**

>     Input: $matrix = [ [0, 0, 0],
>                        [1, 0, 1],
>                      ]
>     Output: 2
>     Row 2 has the maximum ones, so return row 2.

> **Example 3**

>     Input: $matrix = [ [0, 0],
>                        [1, 1],
>                        [0, 0],
>                      ]
>     Output: 2
>     Row 2 have the maximum ones, so return row 2.


The most straightforward solution is to

- create an array containing the number of ones for each row of the matrix,
- find the maximum number of ones in that array (making sure that we get a `0` for an empty array,
- find the index of the first entry in the array that is equal to that maximum,<br/>and return it as a row number (adding 1 because the row numbers start with 1).

This translates quite easily into Perl code.
And there's not even much to say about any possible performance optimizations...

```perl
use v5.36;

use List::Util qw( max first );

sub maximum_ones( $matrix ) {
    # Get the number of ones for each row.
    my @n_ones = map scalar grep( $_ == 1, $_->@* ), $matrix->@*;
    
    # Find the highest number of ones.
    my $max_n_ones = max( @n_ones );
    
    # Return the first row number (1-based, not 0-based!)
    # that has that highest number of ones.
    return 1 + first { $n_ones[$_] == $max_n_ones } 0..$#n_ones;
}
```

## Task 2: Sort by 1 bits

> You are give an array of integers, @ints.<br/>
> Write a script to sort the integers in ascending order by the number of 1 bits in their binary representation. In case more than one integers have the same number of 1 bits then sort them in ascending order.<br/>

> **Example 1**

>     Input: @ints = (0, 1, 2, 3, 4, 5, 6, 7, 8)
>     Output: (0, 1, 2, 4, 8, 3, 5, 6, 7)
>     0 = 0 one bits
>     1 = 1 one bits
>     2 = 1 one bits
>     4 = 1 one bits
>     8 = 1 one bits
>     3 = 2 one bits
>     5 = 2 one bits
>     6 = 2 one bits
>     7 = 3 one bits

> **Example 2**

>     Input: @ints = (1024, 512, 256, 128, 64)
>     Output: (64, 128, 256, 512, 1024)
>     All integers in the given array have one 1-bits, so just sort them in ascending order.

This task, too, is quite straightforward, once we have solved how to count the one-bits in a number.

So let's go for that first.<br/>
My preferred solution to count bits is to let `unpack` do the work for me.<br/>The `'%b'` format for `unpack` returns the number of bits in the bit vector we pass in as data (see [here](https://perldoc.perl.org/functions/unpack)). So we turn our number into a bit vector using `pack( 'i', $number )` and let `unpack` do the counting.

Once we have a function for that, sorting the input array is simple, using a comparison code block for `sort`.<br/>It compares first the number of bits of the two numbers given in `$a`and `$b`,
and if they are equal, it uses the numbers themselves. The well-known Perl idiom using the 'space-ship' operator, which returns `-1`, `0`, or `+1`, and a *logical or* that continues with the next comparison only when needed (the previous one returned a `0`) makes it easy.

And that's all! 

```perl
use v5.36;

sub n_bits( $n ) {
    return unpack "%b*", pack "i", $n;
}

sub sort_by_1_bits( @ints ) {
    return sort { n_bits( $a ) <=> n_bits( $b ) || $a <=> $b } @ints;
}
```

#### **Thank you for the challenge!**
