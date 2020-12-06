use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 089
=========================

Task #2
-------
*Magical Matrix*

Submitted by: Mohammad S Anwar

Write a script to display matrix as below with numbers 1 - 9. Please make sure
numbers are used once.

 [ a b c ]
 [ d e f ]
 [ g h i ]

So that it satisfies the following:

 a + b + c = 15
 d + e + f = 15
 g + h + i = 15
 a + d + g = 15
 b + e + h = 15
 c + f + i = 15
 a + e + i = 15
 c + e + g = 15

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Although the Task is to construct a normal magic square of order 3 only, the
solution below implements the Siamese (or De la Loubère) method which works for
any odd-numbered order greater than or equal to 3. Reference:

    https://en.wikipedia.org/wiki/Siamese_method

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 089, Task #2: Magical Matrix (Raku)\n".put;
}

my UInt constant $DEFAULT-ORDER = 3;

#==============================================================================
sub MAIN
(
    #| (Odd integer >= 3; defaults to 3) Order of normal magic square

    UInt:D $order where { $order >= 3 && $order % 2 == 1 } = $DEFAULT-ORDER
)
#==============================================================================
{
    "A normal magic square of order $order:\n".put;

    my UInt        $width  = ($order * $order).chars;
    my Array[UInt] @square = build-square($order);

    for 0 .. @square.end -> UInt $row
    {
        " [ %s ]\n".printf:
              @square[$row].map( { '%*s'.sprintf: $width, $_ } ).join: ' ';
    }
}

#------------------------------------------------------------------------------
# Use the Siamese method to construct a normal magic square with odd order >= 3
#
sub build-square( UInt:D $order --> Array:D[Array:D[UInt:D]] )
#------------------------------------------------------------------------------
{
    my Array[UInt] @square  = Array[UInt].new([ 0 xx $order ]) xx $order;
    my UInt        $max-idx = $order - 1;
    my UInt        $row     = 1;
    my UInt        $col     = ((($order / 2)) - 1).floor;

    # From the Wikipedia article cited above:
    #
    # "... starting from the central box of the first row with the number 1 ...
    # the fundamental movement for filling the boxes is diagonally up and right
    # (↗), one step at a time. When a move would leave the square, it is
    # wrapped around to the last row or first column, respectively.
    #
    # "If a filled box is encountered, one moves vertically down one box (↓)
    # instead, then continuing as before."

    for 1 .. $order * $order -> UInt $n
    {
        if    $row == 0 && $col == $max-idx    # At the top right corner:
        {                                      #   Drop down one row
            $row = 1;
        }
        elsif $row == 0                        # On the top edge:
        {                                      #   Wrap around to the last row
            $row = $max-idx;                    
            ++$col;
        }
        elsif $col == $max-idx                 # On the right edge:
        {                                      #   Wrap around to first column
            $col = 0;                           
            --$row;
        }
        elsif @square[$row - 1; $col + 1] > 0  # Next square is already filled:
        {                                      #   Drop down one row
            ++$row;
        }
        else                                   # Default case:
        {                                      #   Move diagonally up and right
            --$row;
            ++$col;
        }

        @square[$row; $col] = $n;
    }

    return @square;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
