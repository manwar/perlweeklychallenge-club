#!perl

################################################################################
=comment

Perl Weekly Challenge 387
=========================

TASK #1
-------
*Rearrange Binary String*

Submitted by: Mohammad Sajid Anwar

You are given a binary string.

Write a script to re-arrange the given binary string [so] that all occurrences
of "01" are simultaneously replaced with "10" until no occurrences of "01"
exist. Finally return the total steps needed.

Example 1

  Input: $str = "111000"
  Output: 0

  The string already has all 1s on the left and 0s on the right.
  There are no occurrences of "01", so zero step needed.

Example 2

  Input: $str = "00011"
  Output: 4

  Step 1: "00101"
  Step 2: "01010"
  Step 3: "10100"
  Step 4: "11000"

Example 3

  Input: $str = "01011"
  Output: 3

  Step 1: "10101"
  Step 2: "11010"
  Step 3: "11100"

Example 4

  Input: $str = "010101"
  Output: 3

  Step 1: "101010"
  Step 2: "110100"
  Step 3: "111000"

Example 5

  Input: $str = "00001"
  Output: 4

  Step 1: "00010"
  Step 2: "00100"
  Step 3: "01000"
  Step 4: "10000"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A binary string is entered on the command-line.
3. If this binary string is preceded by the flags "-v" or "--verbose" then the
   steps are detailed, as in the Examples.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [-v|--verbose] <str>
  perl $0

    <str>           A binary string
    -v|--verbose    Show the steps? [default: False]
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 387, Task #1: Rearrange Binary String (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $verbose;

    GetOptions( verbose => \$verbose )
        or error( 'Invalid command-line argument(s)' );

    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        my ($str) = @ARGV;

        $str =~ / ^ [01]* $ /x
            or error( qq["$str" is not a valid binary string] );

        print qq[Input:  \$str = "$str"\n];

        my $steps = count_steps( $str, $verbose );

        print "Output: $steps\n";
    }
    else
    {
        error( "Expected 1 or 0 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub count_steps
#-------------------------------------------------------------------------------
{
    my ($str, $verbose) = @_;

    $str =~ / ^ [01]* $ /x or die qq["$str" is not a valid binary string];

    my  $step = 0;

    while ($str =~ / 01 /x)
    {
        $str =~ s/ 01 /10/gx;

        ++$step;

        if ($verbose)
        {
            print  "\n" if $step == 1;
            printf qq[  Step %d: "%s"\n], $step, $str;
        }
    }

    print "\n" if $verbose && $step > 0;

    return $step;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $steps = count_steps( $str );

        is $steps, $expected, $test_name;
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
Example 1|111000|0
Example 2|00011 |4
Example 3|01011 |3
Example 4|010101|3
Example 5|00001 |4
