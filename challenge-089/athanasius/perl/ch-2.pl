#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Although the Task is to construct a normal magic square of order 3 only, the
solution below implements the Siamese (or De la Loubère) method which works for
any odd-numbered order greater than or equal to 3. Reference:

    https://en.wikipedia.org/wiki/Siamese_method

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $DEFAULT_ORDER => 3;
const my $USAGE =>
"Usage:
  perl $0 [<order>]

    [<order>]    (Odd integer >= 3; defaults to 3) Order of normal magic square
";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 089, Task #2: Magical Matrix (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $order = parse_command_line();

    print "A normal magic square of order $order:\n\n";

    my $square = build_square($order);
    my $width  = length ($order * $order);

    for my $row (0 .. $#$square)
    {
        printf " [ %s ]\n",
              join ' ', map { sprintf '%*s', $width, $_ } @{ $square->[$row] };
    }
}

#------------------------------------------------------------------------------
sub build_square                      # Use the Siamese method to construct a
                                      # normal magic square with odd order >= 3
#------------------------------------------------------------------------------
{
    my ($order) = @_;
    my  $square;

    push @$square, [ (0) x $order ] for 1 .. $order;
    
    my $max_idx = $order - 1;
    my $row     = 1;
    my $col     = int( ($order / 2) ) - 1;

    # From the Wikipedia article cited above:
    #
    # "... starting from the central box of the first row with the number 1 ...
    # the fundamental movement for filling the boxes is diagonally up and right
    # (↗), one step at a time. When a move would leave the square, it is
    # wrapped around to the last row or first column, respectively.
    #
    # "If a filled box is encountered, one moves vertically down one box (↓)
    # instead, then continuing as before."

    for my $n (1 .. $order * $order)
    {
        if    ($row == 0 && $col == $max_idx)  # At the top right corner:
        {                                      #   Drop down one row
            $row = 1;
        }
        elsif ($row == 0)                      # On the top edge:
        {                                      #   Wrap around to the last row
            $row = $max_idx;
            ++$col;
        }
        elsif ($col == $max_idx)               # On the right edge:
        {                                      #   Wrap around to first column
            $col = 0;
            --$row;
        }
        elsif ($square->[$row - 1][$col + 1] > 0)
        {                                      # Next square is already filled:
            ++$row;                            #   Drop down one row
        }
        else                                   # Default case:
        {                                      #   Move diagonally up and right
            --$row;
            ++$col;
        }

        $square->[$row][$col] = $n;
    }

    return $square;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
    my $order;

    if    ($args == 0)
    {
        $order =  $DEFAULT_ORDER;
    }
    elsif ($args == 1)
    {
        $order =  $ARGV[0];
        $order =~ /\A$RE{num}{int}\z/ or error(qq["$order" is not an integer]);
        $order >= 3                   or error("Order $order is too small");
    }
    else
    {
        error('Too many command-line arguments');
    }

    return $order;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
