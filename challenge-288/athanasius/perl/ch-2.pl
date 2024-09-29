#!perl

################################################################################
=comment

Perl Weekly Challenge 288
=========================

TASK #2
-------
*Contiguous Block*

Submitted by: Peter Campbell Smith

You are given a rectangular matrix where all the cells contain either x or o.

Write a script to determine the size of the largest contiguous block.

    A contiguous block consists of elements containing the same symbol which
    share an edge (not just a corner) with other elements in the block, and
    where there is a path between any two of these elements that crosses only
    those shared edges.

Example 1

    Input: $matrix = [
                       ['x', 'x', 'x', 'x', 'o'],
                       ['x', 'o', 'o', 'o', 'o'],
                       ['x', 'o', 'o', 'o', 'o'],
                       ['x', 'x', 'x', 'o', 'o'],
                     ]
    Output: 11

        There is a block of 9 contiguous cells containing 'x'.
        There is a block of 11 contiguous cells containing 'o'.

Example 2

    Input: $matrix = [
                       ['x', 'x', 'x', 'x', 'x'],
                       ['x', 'o', 'o', 'o', 'o'],
                       ['x', 'x', 'x', 'x', 'o'],
                       ['x', 'o', 'o', 'o', 'o'],
                     ]
    Output: 11

        There is a block of 11 contiguous cells containing 'x'.
        There is a block of 9 contiguous cells containing 'o'.

Example 3

    Input: $matrix = [
                       ['x', 'x', 'x', 'o', 'o'],
                       ['o', 'o', 'o', 'x', 'x'],
                       ['o', 'x', 'x', 'o', 'o'],
                       ['o', 'o', 'o', 'x', 'x'],
                     ]
    Output: 7

        There is a block of 7 contiguous cells containing 'o'.
        There are two other 2-cell blocks of 'o'.
        There are three 2-cell blocks of 'x' and one 3-cell.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single string is entered on the command-line, e.g., "xxxo xooo xooo xxoo".
   This string comprises whitespace-separated rows; each row contains only the characters 'x' or 'o'. The matrix represented must be rectangular and not
   empty.
3. If $VERBOSE is set to a true value, the output is augmented with a matrix
   diagram showing the different contiguous blocks found, and identifying the
   largest.

=cut
#===============================================================================

use v5.32;        # Enables strictures and warnings
use Const::Fast;
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   => <<END;
Usage:
  perl $0 <matrix-str>
  perl $0

    <matrix-str>    Non-empty matrix string, e.g., "xxxo xooo xooo xxoo"
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 288, Task #2: Contiguous Block (Perl)\n\n";
}

#===============================================================================
package Matrix
#===============================================================================
{
    use List::Util qw( max );
    use Moo;
    use namespace::clean;

    #---------------------------------------------------------------------------
    # Attributes
    #---------------------------------------------------------------------------

    has matrix => ( is => 'ro' );
    has rows   => ( is => 'ro' );
    has cols   => ( is => 'ro' );

    #---------------------------------------------------------------------------
    around BUILDARGS => sub
    #---------------------------------------------------------------------------
    {
        my ($orig, $class, @args) = @_;

        return { matrix_str => $args[ 0 ] }; 
    };

    #---------------------------------------------------------------------------
    sub BUILD
    #---------------------------------------------------------------------------
    {
        my ($self, $args) = @_;

        my  @rows = split / \s+ /x, $args->{ matrix_str };

        scalar @rows > 0                        or error( 'Empty matrix' );

        my $cols = length $rows[ 0 ];

        $rows[ 0 ] =~ / ^ [xo]+ $ /x            or error( 'Invalid character' );

        my @matrix = [ split //, $rows[ 0 ] ];

        for my $i (1 .. $#rows)
        {
            $rows[ $i ] =~ / ^ [xo]+ $ /x       or error( 'Invalid character' );
            length $rows[ $i ] == $cols         or error( 'Ragged array' );

            push @matrix, [ split //, $rows[ $i ] ];
        }

        $self->{ matrix } = \@matrix;
        $self->{ rows }   = scalar @matrix;
        $self->{ cols }   = scalar @{ $matrix[ 0 ] };
    }

    #---------------------------------------------------------------------------
    sub find_largest_block_size
    #---------------------------------------------------------------------------
    {
        my ($self) = @_;
        my  $x_num = 0;
        my  $o_num = 0;

        for my $row (0 .. $self->rows - 1)
        {
            for my $col (0 .. $self->cols - 1)
            {
                my $elem = $self->matrix->[ $row ][ $col ];

                if ($elem eq 'x' || $elem eq 'o')
                {
                    my $num = ($elem eq 'x') ? $x_num++ : $o_num++;

                    $self->_find_block( $elem, "$elem$num", $row, $col );
                }
            }
        }

        return $self->_count_blocks();
    }

    #---------------------------------------------------------------------------
    sub _find_block
    #---------------------------------------------------------------------------
    {
        my ($self, $elem, $marker, $row, $col ) = @_;

        $self->matrix->[ $row ][ $col ] = $marker;

        $self->_search_up   ( $elem, $marker, $row, $col );
        $self->_search_left ( $elem, $marker, $row, $col );
        $self->_search_right( $elem, $marker, $row, $col );
        $self->_search_down ( $elem, $marker, $row, $col );
    }

    #---------------------------------------------------------------------------
    sub _search_up
    #---------------------------------------------------------------------------
    {
        my ($self, $elem, $marker, $row, $col ) = @_;

        if ($row > 0)
        {
            my $up_row = $row - 1;

            if ($self->matrix->[ $up_row ][ $col ] eq $elem)
            {
                $self->matrix->[ $up_row ][ $col ] = $marker;

                $self->_find_block( $elem, $marker, $up_row, $col );
            }
        }
    }

    #---------------------------------------------------------------------------
    sub _search_left
    #---------------------------------------------------------------------------
    {
        my ($self, $elem, $marker, $row, $col ) = @_;

        if ($col > 0)
        {
            my $left_col = $col - 1;

            if ($self->matrix->[ $row ][ $left_col ] eq $elem)
            {
                $self->matrix->[ $row ][ $left_col ] = $marker;

                $self->_find_block( $elem, $marker, $row, $left_col );
            }
        }
    }

    #---------------------------------------------------------------------------
    sub _search_right
    #---------------------------------------------------------------------------
    {
        my ($self, $elem, $marker, $row, $col ) = @_;

        if ($col < $self->cols - 1)
        {
            my $right_col = $col + 1;

            if ($self->matrix->[ $row ][ $right_col ] eq $elem)
            {
                $self->matrix->[ $row ][ $right_col ] = $marker;

                $self->_find_block( $elem, $marker, $row, $right_col );
            }
        }
    }

    #---------------------------------------------------------------------------
    sub _search_down
    #---------------------------------------------------------------------------
    {
        my ($self, $elem, $marker, $row, $col ) = @_;

        if ($row < $self->rows - 1)
        {
            my $down_row = $row + 1;

            if ($self->matrix->[ $down_row ][ $col ] eq $elem)
            {
                $self->matrix->[ $down_row ][ $col ] = $marker;

                $self->_find_block( $elem, $marker, $down_row, $col );
            }
        }
    }

    #---------------------------------------------------------------------------
    sub _count_blocks
    #---------------------------------------------------------------------------
    {
        my ($self) = @_;
        my  %block_counts;

        for my $row (0 .. $self->rows - 1)
        {
            for my $col (0 .. $self->cols - 1)
            {
                ++$block_counts{ $self->matrix->[ $row ][ $col ] };
            }
        }

        my $max_size = max values %block_counts;
        my @max_blocks;

        while (my ($key, $value) = each %block_counts)
        {
            push @max_blocks, $key if $value == $max_size;
        }

        @max_blocks = sort {
                               substr( $a, 0, 1 ) cmp substr( $b, 0, 1 )
                                                  ||
                               substr( $a, 1 )    <=> substr( $b, 1 )

                           } @max_blocks;

        return ($max_size,  \@max_blocks);
    }

    #---------------------------------------------------------------------------
    sub print              # Adapted from print_matrix() in ch-2.pl for Week 266
    #---------------------------------------------------------------------------
    {
        my ($self, $prefix) = @_;
        my  $tab   = ' ' x length $prefix;
        my  @width = (1) x scalar @{ $self->matrix->[ 0 ] };

        for my $row (@{ $self->matrix })
        {
            for my $i (0 .. $#$row)
            {
                my $w = length $row->[ $i ];

                $width[ $i ] = $w if $w > $width[ $i ];
            }
        }

        print "$prefix\[\n";

        for my $row (@{ $self->matrix })
        {
            my @row_str;

            for my $i (0 .. $#$row)
            {
                push @row_str, sprintf '%*s', $width[ $i ], $row->[ $i ];
            }

            printf "%s  [%s]\n", $tab, join ', ', map { "'$_'" } @row_str;
        }

        print "$tab]\n";
    }
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        my $matrix = Matrix->new( $ARGV[ 0 ] );

        $matrix->print( 'Input: $matrix = ', $matrix );

        my ($max_size, $max_blocks) = $matrix->find_largest_block_size;

        print "Output: $max_size\n";

        if ($VERBOSE)
        {
            print "\n";

            $matrix->print( 'Blocks: ' );

            printf "Largest block%s: %s\n", scalar @$max_blocks > 1 ? 's' : '',
                    join ', ', @$max_blocks;
        }
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $matrix_str, $expected) = split / \| /x, $line;

        for ($test_name, $matrix_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my  $matrix    = Matrix->new( $matrix_str );
        my ($max_size) = $matrix->find_largest_block_size;

        is  $max_size, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1|xxxxo xoooo xoooo xxxoo|11
Example 2|xxxxx xoooo xxxxo xoooo|11
Example 3|xxxoo oooxx oxxoo oooxx| 7
