#!perl

################################################################################
=comment

Perl Weekly Challenge 391
=========================

TASK #2
-------
*Arrange Box*

Submitted by: Mohammad Sajid Anwar

You are given an array of box dimensions.

Write a script to determine the maximum number of these boxes that can fit
inside each other in a single stack. For a box to fit inside another, it must be
smaller in both dimensions.

Example 1

  Input: @boxes = ([1, 3], [3, 5], [6, 8], [2, 4])
  Output: 4

  Sort by width ascending: ([1, 3], [2, 4], [3, 5], [6, 8])
  Extract heights: [3, 4, 5, 8]
  [1, 3] -> [2, 4] -> [3, 5] -> [6, 8]

Example 2

  Input: @boxes = ([4, 5], [4, 6], [6, 7], [2, 3], [4, 3])
  Output: 3

  Sort by width ascending: ([2, 3], [4, 6], [4, 5], [4, 3], [6, 7])
  Extract heights: (3, 6, 5, 3, 7)
  [2, 3] -> [4, 5] -> [6, 7]

Example 3

  Input: @boxes = ([5, 5], [5, 5], [5, 5])
  Output: 1

  Sort by width ascending: ([5, 5], [5, 5], [5, 5])
  Extract heights: (5, 5, 5)
  [5, 5]

Example 4

  Input: @boxes = ([2, 100], [3, 200], [4, 300], [5, 50], [5, 400])
  Output: 4

  Sort by width ascending: ([2, 100], [3, 200], [4, 300], [5, 400], [5, 50])
  Extract heights: (100, 200, 300, 400, 50)
  [2, 100] -> [3, 200] -> [4, 300] -> [5, 400]

Example 5

  Input: @boxes = ([10, 20], [15, 10], [20, 30], [12, 18], [16, 25])
  Output: 3

  Sort by width ascending: ([10, 20], [12, 18], [15, 10], [16, 25], [20, 30])
  Extract heights: (20, 18, 10, 25, 30)
  [15, 10] -> [16, 25] -> [20, 30]

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Box dimensions are positive integers greater than zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of strings comprising box dimension pairs (width, height) is entered
   on the command-line. Each dimension must be an integer greater than zero.
   Within each pair, width and height are separated either by a comma (optional-
   ly followed by whitespace), or by whitespace alone.
3. If either "-v" or "--verbose" is entered as a command-line flag, the required
   output (viz., the maximum number of boxes that can be stacked together) is
   supplemented with details of the boxes (smallest to largest) in the biggest
   stack. These details are as shown in the final line of each Example.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use List::Util     qw( uniqint );
use Regexp::Common qw( number );
use Test::More;

const my $RxDims => qr/ ^ (\d+) (?: , \s* || \s+ ) (\d+) $ /x;
const my $USAGE  => <<END;
Usage:
  perl $0 [-v|--verbose] [<dims> ...]
  perl $0

    [<dims> ...]    List of +ve integer box dimensions; e.g., "1, 2" 3,4 "5 6"
    -v|--verbose    Display the boxes in the largest stack?
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 391, Task #2: Arrange Box (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my $verbose;

        GetOptions( verbose => \$verbose )
            or error( 'Invalid command-line flag' );

        my $boxes = parse_box_dims( \@ARGV );

        printf "Input:  \@boxes = (%s)\n", print_boxes( $boxes, ', ' );

        my $stack = stack_boxes( $boxes );

        printf "Output: %d\n", scalar $stack->@*;

        printf "\n%s\n", print_boxes( $stack, ' -> ' )
            if $verbose && scalar @$stack > 0;
    }
}

#-------------------------------------------------------------------------------
sub stack_boxes
#-------------------------------------------------------------------------------
{
    my ($boxes) = @_;

    return [] if scalar @$boxes == 0;

    my %w2h;                        # Width => [heights]

    push $w2h{ $_->[0] }->@*, $_->[1] for @$boxes;

    $w2h{ $_ }  = [ uniqint sort { $a <=> $b } $w2h{ $_ }->@* ] for keys %w2h;
    my @widths  = sort { $a <=> $b } keys %w2h;
    my $width   = shift @widths;
    my @stack   = [ $width, $w2h{ $width }[0] ];
    my @max_stk = @stack;

    L_OUTER:
    for my $width (@widths)
    {
        my $prev_height = $stack[-1][1];

        for my $height ($w2h{ $width }->@*)
        {
            if ($height > $prev_height)
            {
                push @stack, [ $width, $height ];
                next L_OUTER;
            }
        }

        @max_stk = @stack if scalar @stack > scalar @max_stk;
        @stack   = [ $width, $w2h{ $width }[0] ];
    }

    @max_stk = @stack if scalar @stack > scalar @max_stk;

    return \@max_stk;
}

#-------------------------------------------------------------------------------
sub parse_box_dims
#-------------------------------------------------------------------------------
{
    my ($dims) = @_;
    my  @boxes;

    for my $dim (@$dims)
    {
        $dim =~ $RxDims;

        my $width  = $1;
        my $height = $2;

        $width  =~  / ^ $RE{num}{int} $ /x
                    or error( qq["$width" is not a valid integer] );
        $width  > 0 or error( 'Width is zero');

        $height =~  / ^ $RE{num}{int} $ /x
                    or error( qq["$height" is not a valid integer] );
        $height > 0 or error( 'Height is zero');

        push @boxes, [ $width, $height ];
    }

    return \@boxes;
}

#-------------------------------------------------------------------------------
sub print_boxes
#-------------------------------------------------------------------------------
{
    my ($boxes, $join) = @_;

    return join $join, map { '[' . $_->[0] . ', ' . $_->[1] . ']' } @$boxes;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $expected, @dims) = split / \| /x, $line;

        for ($test_name, $expected, @dims)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $boxes     = parse_box_dims( \@dims );
        my $max_stack = scalar stack_boxes( $boxes )->@*;

        is $max_stack, $expected, $test_name;
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
Example 1|4| 1   3| 3   5| 6   8| 2  4
Example 2|3| 4   5| 4   6| 6   7| 2  3| 4   3
Example 3|1| 5   5| 5   5| 5   5
Example 4|4| 2 100| 3 200| 4 300| 5 50| 5 400
Example 5|3|10  20|15  10|20  30|12 18|16  25
One box  |1|42  17
No boxes |0
2nd stack|4| 1   1| 2   2| 3   3| 4  2| 5   3|6 4|7 5|8 1
