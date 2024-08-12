# Knights of Class

**Challenge 281 solutions in Perl by Matthias Muth**

## Task 1: Check Color

> You are given coordinates, a string that represents the coordinates of a square of the chessboard as shown below:<br/>
> <br/>
> Write a script to return true if the square is light, and false if the square is dark.<br/>
> <br/>
> Example 1<br/>
> Input: \$coordinates = "d3"<br/>
> Output: true<br/>
> <br/>
> Example 2<br/>
> Input: \$coordinates = "g5"<br/>
> Output: false<br/>
> <br/>
> Example 3<br/>
> Input: \$coordinates = "e6"<br/>
> Output: true<br/>

Interpreting column names '`a`' to '`z`' as numbers from 1 to 8,
the lower left square ('`a1`') has the column/row coordinates `(1,1)`.  The sum of these two coordinate values is 2, and the square is a dark one.

It is easy to see that *all* dark squares have a coordinate sum that is even, because whenever you add 1 to any of the coordinates, making the sum odd, you end up on a light square, and adding (or subtracting) another 1 brings you to a dark square again.

So we only have to add the row and column coordinates, and check whether the result is odd.

Now I made it simple, by just summing up the *ASCII character values* of the two letters of the field coordinates (`'a'` and `'1'` for that example).

`'a'` to `'h'` have ASCII values of `0x61` to `0x68`. The lower four bits contain the corresponding coordinate values from 1 to 8.
The same is valid for the digits characters `'1'` to `'8'`, whose ASCII values are `0x31` to `0x38`.

So if I sum up the ASCII values of the characters `'a'` and `'1'` and divide by 2, it is the same as if I added the numerical coordinates 1 and 1 and divided by 2.

This makes my solution very short: Split the coordinate string into characters, map them to their ASCII value (using `ord` with the default `$_` parameter), add them together (using `List::Util`'s `sum` function), and use the modulo operator (`%`) to get the remainder. If it is `1`, it's a light square, so we can directly use the remainder as a truth value.


```perl
use v5.36;
use List::Util qw( sum );

sub check_color( $coordinates ) {
    return sum( map ord, split "", $coordinates ) % 2;
}
```

## Task 2: Knight’s Move

> A Knight in chess can move from its current position to any square two rows or columns plus one column or row away. So in the diagram below, if it starts a S, it can move to any of the squares marked E.<br/>
> Write a script which takes a starting position and an ending position and calculates the least number of moves required.<br/>
> <br/>
> <br/>
> Example 1<br/>
> Input: \$start = 'g2', \$end = 'a8'<br/>
> Ouput: 4<br/>
> g2 -> e3 -> d5 -> c7 -> a8<br/>
> <br/>
> Example 2<br/>
> Input: \$start = 'g2', \$end = 'h2'<br/>
> Ouput: 3<br/>
> g2 -> e3 -> f1 -> h2<br/>

I was positively surprised by this week's second task, because it requires a more complex algorithmic approach than usual. Great challenge!

##### Approach

My solution is based on trying to build something like a 'distance map'.

The knight's initial position has distance 0 (no move needed).<br/>
From there, there are up to eight squares that can be reached with one move. Those will be marked with distance 1.<br/>
Next, I'll try the eight possible moves from each of those squares having distance 1, and wherever I find a square that is not yet marked with a distance, I do so with the distance of 2.<br/>And so on...

Actually this is a **breadth-first-search** (BFS) algorithm.<br/>Each time a square is marked with a distance, that square's position is put on a queue for the next round. As soon as we are about to mark the end position with its distance, we can stop the process and directly return that distance as the result.

##### Implementation

I love to use and show off 'modern' Perl features, and I am happy that this task offers itself to be implemented using the **class** feature. 

The 'modern' features in my solution include:

- *class* (introduced in Perl 5.38),
- *signatures* (available since Perl 5.20, 10 years ago, and standard since Perl 5.36),
- *for_list* (available since Perl 5.36),
- *chained comparisons* (available since Perl 5.32).

So there is a `class Knight`, and it contains a `field $start` that has to be handed into the constructor when an object is created.

Then there is a method `method n_moves( $end )` that computes the number of moves needed to reach the `$end` position.
This method implements the BFS algorithm as described above.
It uses a hash to store the distance map, with the square coordinates (like `'a1'`) as the leys.

And there is one class method `sub knight_neighbors( $from )`
that returns the list of positions
that can be reached from the `$from` position in one knight's move.
It is used as a helper for the `n_moves` BFS algorithm.
It uses a list of column and row distances `@deltas` for the eight possible neighbor positions.
The coordinates that are returned are in `'a1'` notation.
The conversion to get a column number from a column letter to do the coordinate computing,
and vice versa to get back a `'a1'` type coordinate
is done using the ASCII character value of the column character.  

This is the whole solution, which includes the `Knight` class and the function `knight_s_move( $start, $end )` that can be called with the example input.

```perl
use v5.38;
use feature 'class';
no warnings 'experimental::class';
no warnings 'experimental::for_list';

class Knight {
    field $start :param;

    my @deltas = qw( -2 -1 -2 +1 -1 -2 -1 +2 +1 -2 +1 +2 +2 -1 +2 +1 );
    sub knight_neighbors( $from ) {
        my ( $a_to_h, $row ) = split "", $from;
        my $col = ord( $a_to_h ) - ord( 'a' ) + 1;
        my @neighbors;
        for my ( $dc, $dr ) ( @deltas ) {
            if ( 1 <= $col + $dc <= 8 && 1 <= $row +$dr <= 8 ) {
                my $square = chr( ord( $a_to_h ) + $dc ) . ( $row + $dr );
                push @neighbors, $square;
            }
        }
        return @neighbors;
    }

    method n_moves( $end ) {
        my %distances = ( $start => 0 );
        my @queue = ( $start );
        while ( my $square = shift @queue ) {
            for my $next ( knight_neighbors( $square ) ) {
                next
                    if exists $distances{$next};
                return $distances{$square} + 1
                    if $next eq $end;
                $distances{$next} = $distances{$square} + 1;
                push @queue, $next;
            }
        }
    }
}

sub knight_s_move( $start, $end ) {
    return Knight->new( start => $start )->n_moves( $end );
}
```

#### **Thank you for the challenge!**
