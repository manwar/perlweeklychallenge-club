#!perl

################################################################################
=comment

Perl Weekly Challenge 400
=========================

TASK #1
-------
*Largest Interval*

Submitted by: Ali Moradi

You are given a positive integer.

Write a script that generates a sequence of integers from 1 to given positive
integer, filtering out any numbers that contain repeating digits (e.g., 11, 99,
100, and 101 are excluded) and return the biggest jump.

Example 1

  Input: $int = 20
  Output: 2

  Biggest jump between 10 and 12.

Example 2

  Input: $int = 110
  Output: 4

  Biggest jump between 98 and 102.

Example 3

  Input: $int = 500
  Output: 11

  Biggest jump between:
  a) 109 and 120 => 11
  b) 219 and 230 => 11
  c) 329 and 340 => 11
  d) 439 and 450 => 11

Example 4

  Input: $int = 2026
  Output: 105

  Biggest jump between 1098 and 1203.

Example 5

  Input: $int = 10000
  Output: 105

  The largest gap is 105, between 1098 and 1203. And again between 8796 and 
  8901.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. A positive integer is greater than zero.
2. A jump is from a number containing no repeating digits to another number con-
   taining no repeating digits. So, e.g., if $int = 11 then the maximum jump is
   1; but if $int = 12, the maximum jump is 2 (from 10 to 12).
3. If 2 or more jumps have the maximum size, only the first is detailed in the
   verbose output.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A positive integer is entered on the command-line.
3. If -v (or --verbose) is entered on the command-line, the start and end points
   of the (first) jump with maximum size are displayed after the standard out-
   put.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use Number::Format qw( format_number );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [-v] <int>
  perl $0

    <int>    A positive integer
    -v       Show start and end of max jump? [default: false]
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 400, Task #1: Largest Interval (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $verbose;

    GetOptions( verbose => \$verbose ) or error( 'Invalid command-line flag' );

    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        my $int = $ARGV[0];

        $int =~ / ^ $RE{num}{int} $ /x
                 or error( qq["$int" is not a valid integer] );
        $int > 0 or error( "$int is not positive" );

        printf "Input:  \$int = %s\n", format_number( $int );

        my ($jump, $start, $end) = find_largest_interval( $int );

        printf "Output: %s\n", format_number( $jump );
        printf "\nBiggest jump between %s and %s\n",
                format_number( $start ), format_number( $end ) if $verbose;
    }
    else
    {
        error( "Expected 1 or 0 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_largest_interval
#-------------------------------------------------------------------------------
{
    my ($int)                =  @_;
    my ($jump, $start, $end) = (0, 1, 1);
    my  $local_start         =  $start;

    L_OUTER: for my $i (2 .. $int)
    {
        my @digits = split //, $i;
        my %count;

        for my $d (@digits)
        {
            next L_OUTER if ++$count{ $d } > 1;
        }

        my  $local_jump = $i - $local_start;

        if ($local_jump > $jump)
        {
            $jump  = $local_jump;
            $start = $local_start;
            $end   = $i;
        }

        $local_start = $i;
    }

    return $jump, $start, $end;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int, $exp_jump, $exp_start, $exp_end) =
             split / \| /x, $line;

        for ($test_name, $int, $exp_jump, $exp_start, $exp_end)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my ($jump, $start, $end) = find_largest_interval( $int );

        is $jump,  $exp_jump,  "$test_name: jump";
        is $start, $exp_start, "$test_name: start";
        is $end,   $exp_end,   "$test_name: end";
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
Example 1|   20|  2|  10|  12
Example 2|  110|  4|  98| 102
Example 3|  500| 11| 109| 120
Example 4| 2026|105|1098|1203
Example 5|10000|105|1098|1203
