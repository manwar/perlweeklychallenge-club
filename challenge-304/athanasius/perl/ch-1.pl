#!perl

################################################################################
=comment

Perl Weekly Challenge 304
=========================

TASK #1
-------
*Arrange Binary*

Submitted by: Mohammad Sajid Anwar

You are given a list of binary digits (0 and 1) and a positive integer, $n.

Write a script to return true if you can re-arrange the list by replacing at
least $n digits with 1 in the given list so that no two consecutive digits are 1
otherwise return false.

Example 1

  Input: @digits = (1, 0, 0, 0, 1), $n = 1
  Output: true

  Re-arranged list: (1, 0, 1, 0, 1)

Example 2

  Input: @digits = (1, 0, 0, 0, 1), $n = 2
  Output: false

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Replacement: Only a 0 digit may be replaced with a 1 digit.
2. The given $n must be greater than zero.

Discussion
----------
In the Task description, juxtaposition of the words "re-arrange" and "replace"
creates ambiguity. Is the requirement to:

 1. replace $n 0 digits with 1 digits, leaving them in their original places; or
 2. rearrange all the digits (after replacement) into the required sequence?

Rather than choose between these alternatives, I have decided to solve both. For
example, an input of @digits = (1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1) and $n = 1 will
produce the following result:

    Input: @digits = (1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1), $n = 1
    Output
      Can rearrange: true
      Can replace:   false

which indicates that the digits CAN be re-arranged with no two consecutive 1s:

    (1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1)

but CANNOT have no consecutive 1s if there is replacement but no rearrangement
(because there are consecutive 1s in the original list).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A binary string and a positive integer are entered on the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <digits> <n>
  perl $0

    <digits>    A non-empty string of binary digits
    <n>         A positive integer
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 304, Task #1: Arrange Binary (Perl)\n\n";
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
    elsif ($argc == 2)
    {
        my ($digits, $n) = @ARGV;

        $digits =~ / ^ [01]+ $ /x
               or error( qq["$digits" is not a valid string of binary digits] );

        $n =~ / ^ $RE{num}{int} $ /x
               or error( qq["$n" is not a valid integer] );

        $n > 0 or error( "$n is not positive" );

        my @digits = split //, $digits;

        printf "Input: \@digits = (%s), \$n = %d\n", join( ', ', @digits ), $n;

        my ($can_rearrange, $can_replace) = arrange( \@digits, $n );

        print  "Output\n";
        printf "  Can rearrange: %s\n", $can_rearrange ? 'true' : 'false';
        printf "  Can replace:   %s\n", $can_replace   ? 'true' : 'false';
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub arrange
#-------------------------------------------------------------------------------
{
    my ($digits, $n) = @_;

    my  $ones  = 0;
        $ones += $_ for @$digits;
    my  $zeros = scalar @$digits - $ones;

    my  $can_rearrange = ($ones + $n) - ($zeros - $n) <= 1;
    my  $can_replace   =  $can_rearrange;

    if ($can_replace)
    {
        my $digit_str = join '', @$digits;
        $can_replace  = ($digit_str =~ / 11 /x) ? 0 : replace( $digit_str, $n );
    }

    return ($can_rearrange, $can_replace);
}

#-------------------------------------------------------------------------------
sub replace
#-------------------------------------------------------------------------------
{
    my ($digits, $n) = @_;

    --$n if $digits =~ / ^ 0 /x;

    if ($n > 0)
    {
        --$n if $digits =~ / 0 $ /x;

        while ($n > 0)
        {
            $digits =~ s/ 000 /010/x or last;
            --$n;
        }
    }

    return $n == 0;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $digit_str, $n, $exp_rearrange, $exp_replace) =
             split / \| /x, $line;

        for ($test_name, $digit_str, $n, $exp_rearrange, $exp_replace)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my  @digits = split //, $digit_str;
        my ($can_rearrange, $can_replace) = arrange( \@digits, $n );
        my  $can_rearrange_str = $can_rearrange ? 'true' : 'false';
        my  $can_replace_str   = $can_replace   ? 'true' : 'false';

        is  $can_rearrange_str, $exp_rearrange, "$test_name: rearrange";
        is  $can_replace_str,   $exp_replace,   "$test_name: replace";
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
Example 1|10001      |1|true |true
Example 2|10001      |2|false|false
Groups 1 |11100000011|1|true |false
Groups 2 |1000010001 |2|true |true
Groups 3 |1000001    |2|true |true
