#!perl

################################################################################
=comment

Perl Weekly Challenge 384
=========================

TASK #2
-------
*Special Binary Substrings*

Submitted by: Mohammad Sajid Anwar

You are given a binary string.

Write a script to return all non-empty substrings (distinct) that have the same
number of 0's and 1's, and all the 0's and all the 1's in these substrings are grouped consecutively.

Example 1

  Input: $binary = "0101"
  Output: ("01", "10")

Example 2

  Input: $binary = "000111"
  Output: ("000111", "0011", "01")

Example 3

  Input: $binary = "000011"
  Output:  ("0011", "01")

Example 4

  Input: $binary = "10011100"
  Output: ("10", "0011", "01", "1100")

Example 5

  Input: $binary = "00000"
  Output: ()

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

Assumption
----------
Since the Task description does not specify the order in which substrings are to
be output, I assume that the Example outputs may be re-ordered to match the out-
put of the algorithm used.

Algorithm
---------
Search the input string for candidate substrings, from shortest to longest. In
each case, search for the substring beginning with '0' before searching for its
counterpart beginning with '1'. Hence, the search proceeds as follows:

    01, 10, 0011, 1100, 000111, 111000, ...

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <binary>
  perl $0

    <binary>    A binary string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 384, Task #2: Special Binary Substrings (Perl)\n\n";
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
        my $binary =  $ARGV[0];
           $binary =~ / ^ [01]* $ /x
                or error( qq["$binary" is not a valid binary string] );

        print  qq[Input:  \$binary = "$binary"\n];

        my $substrs = find_special_substrings( $binary );

        printf "Output: (%s)\n", join ', ', map { qq["$_"] } @$substrs;
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_special_substrings
#-------------------------------------------------------------------------------
{
    my ($binary) =  @_;
        $binary  =~ / ^ [01]* $ /x
            or die qq["$binary" is not a valid binary string];

    my  @substrs;

    for my $len (1 .. int( length( $binary ) / 2))
    {
        my $sub = ('0' x $len) . ('1' x $len);

        for my $s ($sub, scalar reverse $sub)
        {
            push @substrs, $s if $binary =~ / $s /x;
        }
    }

    return \@substrs;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $binary, @expected) = split / \| /x, $line;

        for ($test_name, $binary, @expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $substrs = find_special_substrings( $binary );

        is_deeply $substrs, \@expected, $test_name;
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
Example 1|0101    |01|10
Example 2|000111  |01|0011|000111
Example 3|000011  |01|0011
Example 4|10011100|01|10|0011|1100
Example 5|00000
