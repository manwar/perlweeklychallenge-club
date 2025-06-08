#!perl

################################################################################
=comment

Perl Weekly Challenge 324
=========================

TASK #1
-------
*2D Array*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers and two integers $r amd $c.

Write a script to create two dimension array having $r rows and $c columns using
the given array.

Example 1

  Input: @ints = (1, 2, 3, 4), $r = 2, $c = 2
  Output: ([1, 2], [3, 4])

Example 2

  Input: @ints = (1, 2, 3), $r = 1, $c = 3
  Output: ([1, 2, 3])

Example 3

  Input: @ints = (1, 2, 3, 4), $r = 4, $c = 1
  Output: ([1], [2], [3], [4])

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Array dimensions $r and $c are non-zero, unsigned integers.
2. The input integers must exactly fit into the $r by $c array; i.e., |@ints| =
   $r * $c.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The desired number of rows and columns are entered as named arguments on the
   command-line, followed by the elements to be used in populating the array.
3. If the input elements contain negative integers, the first negative integer
   must be preceded by "--" to signal that it is not a command-line flag.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [-r] [-c] [<ints> ...]
  perl $0

    -r              Number of rows    (integer > 0)
    -c              Number of columns (integer > 0)
    [<ints> ...]    Array elements    (1+ integers)
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 324, Task #1: 2D Array (Perl)\n\n";
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
    elsif ($argc >  2)
    {
        my ($r, $c, $ints) = parse_command_line();

        printf "Input:  \@ints = (%s), \$r = %d, \$c = %d\n",
                join( ', ', @$ints ), $r, $c;

        my $two_dim = make_array( $ints, $r, $c );

        printf "Output: (%s)\n", 
                join ', ', map { '[' . join( ', ', @$_ ) . ']' } @$two_dim;
    }
    else
    {
        error( "Expected 0 or 3+ command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub make_array
#-------------------------------------------------------------------------------
{
    my ($ints, $r, $c) = @_;

    scalar @$ints == $r * $c
        or die "Mismatch between array dimensions and number of elements\n";

    my @two_dim;
    my @row = $ints->[ 0 ];

    for my $i (1 .. $#$ints)
    {
        if ($i % $c == 0)
        {
            push @two_dim, [ @row ];

            @row = $ints->[ $i ];
        }
        else
        {
            push @row, $ints->[ $i ];
        }
    }

    push @two_dim, [ @row ];

    return \@two_dim;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($r, $c);

    GetOptions
    (
        'r=i' => \$r,
        'c=i' => \$c,

    ) or error( 'Invalid command-line argument(s)' );

    / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
        for $r, $c, @ARGV;

    $_ > 0                 or error( "$_ is not positive" )
        for $r, $c;

    scalar @ARGV == $r * $c
        or error( 'Mismatch between array dimensions and number of elements' );

    return ($r, $c, \@ARGV);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int_str, $r, $c, $exp_str) = split / \| /x, $line;

        for ($test_name, $int_str, $r, $c, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints    = split / \s+ /x, $int_str;
        my $two_dim = make_array( \@ints, $r, $c );
        my @expected;

        for my $row (split / \; /x, $exp_str)
        {
            push @expected, [ grep { / \d /x } split / \s+ /x, $row ];
        }

        is_deeply \@expected, $two_dim, $test_name;
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
Example 1|1 2 3 4|2|2|1  2; 3 4
Example 2|1 2 3  |1|3|1  2  3
Example 3|1 2 3 4|4|1|1; 2; 3; 4
