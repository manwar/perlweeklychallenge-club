# The Simple and the Fast

**Challenge 288 solutions in Perl by Matthias Muth**

Two quite different solutions for Task 1:<br/>
'The Simple', looping away from the input number until it finds a palindrome, and<br/>
'The Fast', which *constructs* three palindromes that are candidates to be the closest,
and then chooses among them.<br/>
Read more below!

And for Task 2, a 'recursive flood-filling-and-counting' solution.

Great challenges!<br/>
Thank you, Mohammad Anwar and Peter Campbell Smith!

## Task 1: Closest Palindrome

> You are given a string, \$str, which is an integer.<br/>
> Write a script to find out the closest palindrome, not including itself. If there are more than one then return the smallest.<br/>
> The closest is defined as the absolute difference minimized between two integers.<br/>
> <br/>
> Example 1<br/>
> Input: \$str = "123"<br/>
> Output: "121"<br/>
> <br/>
> Example 2<br/>
> Input: \$str = "2"<br/>
> Output: "1"<br/>
> There are two closest palindrome "1" and "3". Therefore we return the smallest "1".<br/>
> <br/>
> Example 3<br/>
> Input: \$str = "1400"<br/>
> Output: "1441"<br/>
> <br/>
> Example 4<br/>
> Input: \$str = "1001"<br/>
> Output: "999"<br/>

#### The Simple

I first thought about *generating* the closest palindrome,
but seeing the rich variety of cases in the examples,
I found it too complicated at first.
That's why I did a quick and simple 'brute force' approach.

This was really easy to write (and easy to read, I hope!).<br/>
Testing a number for being a palindrome in Perl is as simple as it can get:<br/>
    `reverse( $s ) eq $s`.<br/>

So let's try every possible distance, from close to further away.
Trying a distance value first below our number and then above
already gives us the right priority.
If the number at that distance is a palindrone: Done!

```perl
sub closest_palindrome() {
    for ( my $distance = 1; ; ++$distance ) {
        for my $try ( $str - $distance, $str + $distance ) {
            return $try
                if reverse( $try ) eq $try;
        }
    }
}
```

This works like a breeze!<br/>
Except that for large values, looping over all possible numbers  may take a while. 

So that 'constructing' idea didn't get out of my head,
because it would be so much faster!<br/>
And I found a solution, too!

#### The Fast

Let's consider input numbers with an even number of digits first.
Like `345678`.<br/>
Splitting it into a left half and a right half, the general form is<br/>
                $` L_{1} \cdots L_{n} R_{1} \cdots R_{n} `$.<br/>
Looking for a palindrome that is close,
any changes we do to the original number should preferably be in the 'lower' digits
(those further to the right).
So for a good guess, let's keep the left part as it is,
and mirror it to the right to get a palindrome:<br/>
                $` L_{1} \cdots L_{n} L_{n} \cdots L_{1} `$.<br/>
This gives us `345543`.

We see that actually the only degrees of freedom we have are in the left part,
because for any palindrome, the right part is fully determined by the left part.

The left part kind of identifies a 'block' of numbers of $n$ digits on the right side,
ranging from  $` 0 0 \cdots 0 `$ to $` 9 9 \cdots 9 `$.
There is exactly one palindrome in each block
(where the right side is equal to the left side reversed).
It's obvious that the palindromes 'closest' to our input number
can only be in the same block, one block above or one block below.

As each 'block' contains exactly one palindrome,
we only need to generate the three palindromes of those three blocks,
and then choose the closest.

To illustrate this, for our example of `345678` with its left part of `345`,
one of these three palindromes will be the closest:

* The left part, *in*creased by one, then concatenated with the reversed result of that:<br/>
        $L_{1} \cdots ( L_{n} + 1) ( L_{n} + 1 ) \dots L_{1}$:    `346-643`

* The left part itself, concatenated with its reversed:<br/>
        $L_{1} \cdots L_{n} L_{n} \dots L_{1}$:                          `345-543`  (this is the closest!)

* The left part, *de*creased by one, then concatenated with itself reversed:<br/>
        $L_{1} \cdots ( L_{n} - 1) ( L_{n} - 1 ) \dots L_{1}$:    `344-443`

We have a special case when the left part consists of `9`s only,
as for example for `999234` with its left part of `999`.
This becomes `1000` when increased, which is one digit longer.
We must make sure to mirror one digit less in this case,
or we can simply 'construct' the whole palindrome in this case,
using `( '1' . ( '0' x ( $n - 1 ) ) . '1' )`.
That's `1000001` (from `1000-001`) in this example.

The second special case is when the left part is a power of ten,
as for `100234` with its left part of `100`.
The decreased left part will consist of `9`s only,
having one digit less than the original left part.
We generate that palindrome as `( '9' x ( $n - 1 ) )`,
resulting in `99999` (from `99-999`) in this example.

From the three numbers generated,
we choose the one that is closest to our input number,
making sure that the chosen number is not the input number itself.
We also need to prefer a lower number if the distance is the same.

For input numbers with odd lengths, it's actually the same, only that the
'left part' must include the 'middle' digit, and for the 'right' part of
the palindrome, we only use as many digits as needed, *not* including
that middle digit.
The two special cases work the same, we 'construct' the palindromes just like before.

We need to deal with one other special case: negative numbers as input.
They are not excluded in the task description
('which is an integer' -- might be a negative integer, too!).
As `0` is a palindrome (well...ahem...),
it is the also the closest palindrome to any negative integer.<br/>
Voilà.

```perl
use v5.36;

sub closest_palindrome( $str ) {
    return undef unless $str =~ /^-?[0-9]+$/;

    # Edge case: negative numbers.
    return "0" if $str < 0;

    my $left_part = substr( $str, 0, int( ( length( $str ) + 1 ) / 2 ) );
    my ( $closest, $closest_distance ) = ( undef, undef );
    for my $try ( $left_part - 1, $left_part, $left_part + 1 ) {
        next unless $try >= 0;    # Edge case on input '0'.
        my $palindrome =
            length $try < length $left_part
                ? '9' x ( length( $str ) - 1 ) :
            length $try > length $left_part
                ? ( '1' . ( '0' x ( length( $str ) - 1 ) ) . '1' )
                : ( $try
                    . substr( reverse( $try ), length( $str ) % 2 ) );
        my $distance = abs( $palindrome - $str );
        if ( $palindrome != $str
            && ( ! defined $closest_distance
                ||  $distance < $closest_distance ) )
        {
            $closest = $palindrome;
            $closest_distance = abs( $palindrome - $str );
        }
    }
    return $closest;
}
```

This is the more direct path to the closest palindrome.<br/> 
Palindrome algorithms for every need! :-)


## Task 2: Contiguous Block

> You are given a rectangular matrix where all the cells contain either x or o.<br/>
> Write a script to determine the size of the largest contiguous block.<br/>
> A contiguous block consists of elements containing the same symbol which share an edge (not just a corner) with other elements in the block, and where there is a path between any two of these elements that crosses only those shared edges.<br/>
> <br/>
> Example 1<br/>
>     Input: \$matrix = [<br/>
>                        ['x', 'x', 'x', 'x', 'o'],<br/>
>                        ['x', 'o', 'o', 'o', 'o'],<br/>
>                        ['x', 'o', 'o', 'o', 'o'],<br/>
>                        ['x', 'x', 'x', 'o', 'o'],<br/>
>                      ]<br/>
>     Ouput: 11<br/>
>         There is a block of 9 contiguous cells containing 'x'.<br/>
>         There is a block of 11 contiguous cells containing 'o'.<br/>
> <br/>
> Example 2<br/>
>     Input: \$matrix = [<br/>
>                        ['x', 'x', 'x', 'x', 'x'],<br/>
>                        ['x', 'o', 'o', 'o', 'o'],<br/>
>                        ['x', 'x', 'x', 'x', 'o'],<br/>
>                        ['x', 'o', 'o', 'o', 'o'],<br/>
>                      ]<br/>
>     Ouput: 11<br/>
>         There is a block of 11 contiguous cells containing 'x'.<br/>
>         There is a block of 9 contiguous cells containing 'o'.<br/>
> <br/>
> Example 3<br/>
>     Input: \$matrix = [<br/>
>                        ['x', 'x', 'x', 'o', 'o'],<br/>
>                        ['o', 'o', 'o', 'x', 'x'],<br/>
>                        ['o', 'x', 'x', 'o', 'o'],<br/>
>                        ['o', 'o', 'o', 'x', 'x'],<br/>
>                      ]<br/>
>     Ouput: 7<br/>
>         There is a block of 7 contiguous cells containing 'o'.<br/>
>         There are two other 2-cell blocks of 'o'.<br/>
>         There are three 2-cell blocks of 'x' and one 3-cell.<br/>

#### Easy and recursive

I am using a recursive flood fill algorithm to traverse contiguous areas.<br/>
Maybe that sounds more complicates than it actually is.

The main function holds  a matrix `@visited`, where we mark all cells that we have identified to be part of an area. The main subroutine finds the next un-visited cell and calls the recursive `flood_and_mark` function, with the input matrix, the row and column coordinates of the cell, and a reference to the `@visited` matrix as parameters.
Of all returned values, the maximum is kept, and returned in the end.

The `flood_and_mark` function is built to return the number of cells that could be 'flood-filled'. At least one for the cell itself, but also added the results of flood-filling all neighbor cells that have the same symbol (`'x'` or `'o'`) and that are not marked visited yet. The most complicated thing here is to find the coordinates of the neighbor cells, without accessing coordinates outside of the matrix.

The number of recursions is the number of cells in the largest contiguous area *at most*.
So for the examples and also for some bigger matrices this should not be a constraint.

I'm using a multiple values `for` loop for iterating of the `( $r, $c )` coordinate pairs of the neighbor cells.
Together with those coordinate pairs being stored 'flat' in the `@neighbors` array this makes things easy.<br/>(The `for_loop` feature, stable and part of the implicit feature bundle since Perl 5.36).

```perl
use v5.36;

use List::Util qw( max );

sub flood_and_mark( $matrix, $r, $c, $visited ) {
    $visited->[$r][$c] = 1;
    my @neighbors = (
        $r > 0                  ? ( $r - 1, $c ) : (),
        $c > 0                  ? ( $r, $c - 1 ) : (),
        $c < $matrix->[$r]->$#* ? ( $r, $c + 1 ) : (),
        $r < $matrix->$#*       ? ( $r + 1, $c ) : (),
    );
    my $symbol = $matrix->[$r][$c];
    my $count = 1;      # For this field itself.
    for my ( $next_r, $next_c ) ( @neighbors ) {
        next
            if $matrix->[$next_r][$next_c] ne $symbol
                || $visited->[$next_r][$next_c];
        $count += flood_and_mark( $matrix, $next_r, $next_c, $visited );
    }
    return $count;
}

sub contiguous_block( $matrix ) {
    my @visited;
    my $max = 0;
    for my $r ( 0..$matrix->$#* ) {
        for my $c ( 0..$matrix->[$r]->$#* ) {
            if ( ! $visited[$r][$c] ) {
                my $area = flood_and_mark( $matrix, $r, $c, \@visited );
                $max = $area
                    if $area > $max;
            }
        }
    }
    return $max;
}
```

#### **Thank you for the challenge!**
