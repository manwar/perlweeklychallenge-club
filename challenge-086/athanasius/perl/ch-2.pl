#!perl

###############################################################################
=comment

Perl Weekly Challenge 086
=========================

Task #2
-------
*Sudoku Puzzle*

Submitted by: Mohammad S Anwar

You are given Sudoku puzzle (9x9).

Write a script to complete the puzzle and must respect the following rules:

a) Each row must have the numbers 1-9 occuring just once.
b) Each column must have the numbers 1-9 occuring just once.
c) The numbers 1-9 must occur just once in each of the 9 sub-boxes (3x3) of the
   grid.

Example:

 [ _ _ _ 2 6 _ 7 _ 1 ]
 [ 6 8 _ _ 7 _ _ 9 _ ]
 [ 1 9 _ _ _ 4 5 _ _ ]
 [ 8 2 _ 1 _ _ _ 4 _ ]
 [ _ _ 4 6 _ 2 9 _ _ ]
 [ _ 5 _ _ _ 3 _ 2 8 ]
 [ _ _ 9 3 _ _ _ 7 4 ]
 [ _ 4 _ _ 5 _ _ 3 6 ]
 [ 7 _ 3 _ 1 8 _ _ _ ]

Output:

 [ 4 3 5 2 6 9 7 8 1 ]
 [ 6 8 2 5 7 1 4 9 3 ]
 [ 1 9 7 8 3 4 5 6 2 ]
 [ 8 2 6 1 9 5 3 4 7 ]
 [ 3 7 4 6 8 2 9 1 5 ]
 [ 9 5 1 7 4 3 6 2 8 ]
 [ 5 1 9 3 2 6 8 7 4 ]
 [ 2 4 8 9 5 7 1 3 6 ]
 [ 7 6 3 4 1 8 2 5 9 ]

As the above puzzle respect the 3 rules including 9-sub-boxes as shown below:

 [ 4 3 5 ] [ 2 6 9 ] [ 7 8 1 ]
 [ 6 8 2 ] [ 5 7 1 ] [ 4 9 3 ]
 [ 1 9 7 ] [ 8 3 4 ] [ 5 6 2 ]

 [ 8 2 6 ] [ 1 9 5 ] [ 3 4 7 ]
 [ 3 7 4 ] [ 6 8 2 ] [ 9 1 5 ]
 [ 9 5 1 ] [ 7 4 3 ] [ 6 2 8 ]

 [ 5 1 9 ] [ 3 2 6 ] [ 8 7 4 ]
 [ 2 4 8 ] [ 9 5 7 ] [ 1 3 6 ]
 [ 7 6 3 ] [ 4 1 8 ] [ 2 5 9 ]

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

The module "Sudoku.pm" provides class Sudoku. An instance of this class repre-
sents a Sudoku grid, which may be empty, partially filled, or complete. The
following methods are provided:

    Name                Description
    -----------------   -------------------------------------------------------
    new                 Reads in a Sudoku puzzle from file
    clone               Creates a deep copy of an existing grid
    insert              Inserts a digit into an empty cell
    display             Returns a string displaying the grid as in the Example
    is_valid            Returns true if the grid complies with rules a), b),
                        and c), false otherwise
    count_empty_cells   Returns the number of empty cells remaining in the grid
                        (an integer in the range 0 to 81)
    select_empty_cell   Returns the coordinates (row and column) of an empty
                        cell for which the number of possible digits is a
                        minimum, together with a list of those digits

The algorithm, implemented in sub solve(), employs backtracking (i.e., a depth-
first search of the potential search tree) via recursion.

Note: The algorithm stops as soon as a valid solution is found. If no solution
is possible, an appropriate message is displayed. However, if more than one
solution is possible, this will not be discovered. (A "well-posed" puzzle has
only a single solution.)

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use File::Basename;
use Regexp::Common qw( number );
use lib            qw( . );
use Sudoku;

const my $DEFAULT  => '../Sudoku-Data/Example.dat';
const my @SUFFIXES => qw( .dat .txt );
const my $USAGE    =>
"Usage:
  perl $0 [<file_path>] -- The name of a file containing a Sudoku puzzle\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 086, Task #2: Sudoku Puzzle (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $file_path = parse_command_line();
    my $original  = Sudoku->new(file => $file_path);
    my $filename  = fileparse($file_path, @SUFFIXES);

    printf "$filename:\n\n%s\n", $original->display;

    if ($original->is_valid)
    {
        if (my $solution = solve($original))
        {
            printf "Solution:\n\n%s", $solution->display;
        }
        else
        {
            print  "No solution found\n";
        }
    }
    else
    {
        print "This puzzle violates the rules: no solution is possible\n";
    }
}

#------------------------------------------------------------------------------
sub solve                                      # Recursive backtracking routine
#------------------------------------------------------------------------------
{
    my ($current) = @_;

    return          if !$current->is_valid;                    # Failure
    return $current if  $current->count_empty_cells == 0;      # Success

    my $cell   = $current->select_empty_cell;
    my @digits = $cell->{digits}->@*;

    return          if  scalar @digits == 0;                   # Failure

    for my $digit (@digits)
    {
        my $next = Sudoku->new(clone => $current);

        $next->insert($cell->{row}, $cell->{col}, $digit);

        my $result = solve($next);                             # Recursive call

        return $result if $result;                             # Success
    }

    return;                                                    # Failure
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $path = $DEFAULT;
    my $args = scalar @ARGV;

    if    ($args == 1)
    {
        $path = $ARGV[0];
    }
    elsif ($args >  1)
    {
        error("Expected a single command-line argument, found $args");
    }

    -e $path or error(qq[The file "$path" does not exist]);
    -s $path or error(qq[The file "$path" is empty]);
    -f $path or error(qq[The file "$path" is not a plain file]);

    return $path;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
