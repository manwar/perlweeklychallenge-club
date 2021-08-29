#!perl

###############################################################################
=comment

Perl Weekly Challenge 126
=========================

TASK #2
-------
*Minesweeper Game*

Submitted by: Cheok-Yin Fung

You are given a rectangle with points marked with either x or *. Please
consider the x as a land mine.

Write a script to print a rectangle with numbers and x as in the Minesweeper
game.

A number in a square of the minesweeper game indicates the number of mines
within the neighbouring squares (usually 8), also implies that there are no
bombs on that square.

Example

 Input:
     x * * * x * x x x x
     * * * * * * * * * x
     * * * * x * x * x *
     * * * x x * * * * *
     x * * * x * * * * x

 Output:
     x 1 0 1 x 2 x x x x
     1 1 0 2 2 4 3 5 5 x
     0 0 1 3 x 3 x 2 x 2
     1 1 1 x x 4 1 2 2 2
     x 1 1 3 x 2 0 0 1 x

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;

const my $FILE  => 'Example.txt';
const my $MINE  => 'x';
const my $EMPTY => '*';
const my $USAGE =>
"Usage:
  perl $0 [<file>]

    [<file>]    The name of a file containing a Minesweeper starting grid\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 126, Task #2: Minesweeper Game (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $file    = parse_command_line();
    my @in_grid = read_in_the_grid( $file );

    print  "Input from $file:\n";
    printf "    %s\n", join ' ', @$_ for @in_grid;

    my @out_grid = number_the_grid( @in_grid );

    print  "\nOutput:\n";
    printf "    %s\n", join ' ', @$_ for @out_grid;
}

#------------------------------------------------------------------------------
sub read_in_the_grid
#------------------------------------------------------------------------------
{
    my ($file) = @_;
    my  @grid;

    open( my $fh, '<', $file )
        or die qq[Cannot open file "$file" for reading, stopped];

    while (my $line = <$fh>)
    {
        $line =~ s/ \s+ //gx;

        push @grid, [ split '', $line ];
    }

    close $fh
        or die qq[Cannot close file "$file", stopped];

    scalar @grid > 0
        or error( 'Empty grid' );

    my $width = scalar @{ $grid[ 0 ] };

    $width > 0
        or error( 'Empty first row' );

    for my $row (0 .. $#grid)
    {
        scalar @{ $grid[ $row ] } == $width
            or error( 'The grid is not a rectangle' );

        for my $col (0 .. $#{ $grid[ $row ] })
        {
            my $point = $grid[ $row ][ $col ];

            $point eq $MINE || $point eq $EMPTY
                or error( qq["$point" is not a valid input character] );
        }
    }

    return @grid;
}

#------------------------------------------------------------------------------
sub number_the_grid
#------------------------------------------------------------------------------
{
    my @in_grid = @_;

    my $max_row = $#in_grid;
    my $max_col = $#{ $in_grid[ 0 ] };
    my @out_grid;

    push @out_grid, [ (0) x ($max_col + 1) ] for 0 .. $max_row;

    for my $row (0 .. $max_row)
    {
        for my $col (0 .. $max_col)
        {
            if  ($in_grid[ $row ][ $col ] eq $MINE)
            {
                $out_grid[ $row ][ $col ] =  $MINE;
            }
            else
            {
                my $count = 0;

                for my $r ($row - 1 .. $row + 1)
                {
                    next if $r < 0 || $r > $max_row;

                    for my $c ($col - 1 .. $col + 1)
                    {
                        next if $r == $row && $c == $col ||
                                $c < 0 || $c > $max_col;

                        ++$count if $in_grid[ $r ][ $c ] eq $MINE;
                    }
                }

                $out_grid[ $row ][ $col ] = $count if $count;
            }
        }
    }

    return @out_grid;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 0 || $args == 1
             or error( "Expected 0 or 1 command line arguments, found $args" );

    my $file = $args ? $ARGV[ 0 ] : $FILE;

    -e $file or error( qq[File "$file" does not exist]      );
    -s $file or error( qq[File "$file" is empty]            );
    -f $file or error( qq[File "$file" is not a plain file] );

    return $file;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
