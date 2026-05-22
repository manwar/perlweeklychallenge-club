#!perl

################################################################################
=comment

Perl Weekly Challenge 374
=========================

TASK #2
-------
*Largest Same-digits Number*

Submitted by: Mohammad Sajid Anwar

You are given a string containing 0-9 digits only.

Write a script to return the largest number with all digits the same in the
given string.

Example 1

  Input: $str = "6777133339"
  Output: 3333

Example 2

  Input: $str = "1200034"
  Output: 4

Example 3

  Input: $str = "44221155"
  Output: 55

Example 4

  Input: $str = "88888"
  Output: 88888

Example 5

  Input: $str = "11122233"
  Output: 222

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. "The largest number with all digits the same in the given string" means: the
   largest number represented by a substring of *contiguous* identical digits.
   For example, for the string "9199", the answer is 99.
2. If the string consists of zero digits only, the answer is 0 regardless of how
   many digits are in the string.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single string of digits (0-9) only is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use List::Util qw( max );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A non-empty string of digits
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 374, Task #2: Largest Same-digits Number (Perl)\n\n";
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
        my $str = $ARGV[0];

        $str =~ / ^ [0-9]+ $ /x or error( 'Invalid string' );

        print qq[Input:  \$str = "$str"\n];

        my $num = find_largest_num( $str );

        print "Output: $num\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_largest_num
#-------------------------------------------------------------------------------
{
    my ($str) =  @_;
        $str  =~ / ^ [0-9]+ $ /x or die 'Invalid string, stopped';

    my @digits  = split //, $str;
    my $current = shift @digits;
    my @candidates;

    for my $digit (@digits)
    {
        if ($digit == $current % 10)
        {
            $current *= 10;
            $current += $digit;
        }
        else
        {
            push @candidates, $current;
            $current = $digit;
        }
    }

    push @candidates, $current;

    return max @candidates;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $num = find_largest_num( $str );

        is $num, $expected, $test_name;
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
Example 1|6777133339|3333
Example 2|1200034   |4
Example 3|44221155  |55
Example 4|88888     |88888
Example 5|11122233  |222
