#!perl

################################################################################
=comment

Perl Weekly Challenge 250
=========================

TASK #2
-------
*Alphanumeric String Value*

Submitted by: Mohammad S Anwar

You are given an array of alphanumeric strings.

Write a script to return the maximum value of alphanumeric string in the given
array.

The value of alphanumeric string can be defined as

  a) The numeric representation of the string in base 10 if it is made up of
     digits only.
  b) otherwise the length of the string

Example 1

  Input: @alphanumstr = ("perl", "2", "000", "python", "r4ku")
  Output: 6

  "perl" consists of letters only so the value is 4.
  "2" is digits only so the value is 2.
  "000" is digits only so the value is 0.
  "python" consits of letters so the value is 6.
  "r4ku" consists of letters and digits so the value is 4.

Example 2

  Input: @alphanumstr = ("001", "1", "000", "0001")
  Output: 1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. An "alphanumeric string" contains letters and/or digits only. So, "+", "-",
   "_", etc., are not allowed.
2. An empty string has no digits, therefore its value is its length (viz. 0).

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<alphanumstr> ...]
  perl $0

    [<alphanumstr> ...]    A non-empty list of alphanumeric strings
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 250, Task #2: Alphanumeric String Value (Perl)\n\n";
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
        my @alphanumstr = @ARGV;

        / ^ [A-Za-z0-9]* $ /x or error( qq[Invalid input string "$_"] )
            for @alphanumstr;

        printf "Input:  \@alphanumstr = (%s)\n",
                join ', ', map { qq["$_"] } @alphanumstr;

        my $max_value = find_max_value( \@alphanumstr );

        print "Output: $max_value\n";
    }
}

#-------------------------------------------------------------------------------
sub find_max_value
#-------------------------------------------------------------------------------
{
    my ($alphanumstr) = @_;
    my  $max_value    = 0;

    for (@$alphanumstr)
    {
        my $value  = (/ ^ [0-9]+ $ /x ? $_ : length) + 0;    # Numify the string

        $max_value = $value if $value > $max_value;
    }

    return $max_value;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $alphanumstrs, $expected) = split / \| /x, $line;

        for ($test_name, $alphanumstrs, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @alphanumstr = split / \s+ /x,  $alphanumstrs;
        my $max_value   = find_max_value( \@alphanumstr );

        is $max_value, $expected, $test_name;
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
Example 1|perl 2 000 python r4ku|6
Example 2|001  1 000 0001       |1
