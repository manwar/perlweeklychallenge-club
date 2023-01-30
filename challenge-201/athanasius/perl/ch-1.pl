#!perl

###############################################################################
=comment

Perl Weekly Challenge 201
=========================

TASK #1
-------
*Missing Numbers*

Submitted by: Mohammad S Anwar

You are given an array of unique numbers.

Write a script to find out all missing numbers in the range 0..$n where $n is
the array size.

Example 1

  Input: @array = (0,1,3)
  Output: 2

  The array size i.e. total element count is 3, so the range is 0..3.
  The missing number is 2 in the given array.

Example 2

  Input: @array = (0,1)
  Output: 2

  The array size is 2, therefore the range is 0..2.
  The missing number is 2.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Assumption
----------
Numbers in the input array are integers.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<array> ...]
  perl $0

    [<array> ...]    A list of 1 or more unique integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 201, Task #1: Missing Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my @array = validate_input();

        printf "Input:  \@array = (%s)\n", join ',', @array;

        my $missing = find_missing_numbers( \@array );

        printf "Output: (%s)\n", join ',', @$missing;
    }
}

#------------------------------------------------------------------------------
sub validate_input
#------------------------------------------------------------------------------
{
    my %element_counts;

    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x                       # Entry is a valid integer
            or error( qq["$_" is not a valid integer] );

        ++$element_counts{ $_ } == 1                          # Entry is unique
            or error( "Duplicate ${_}s in the input array" )
    }

    return @ARGV;
}

#------------------------------------------------------------------------------
sub find_missing_numbers
#------------------------------------------------------------------------------
{
    my ($array) = @_;
    my  $n      = scalar @$array;
    my  @missing;

    L_OUTER:
    for my $m (0 .. $n)
    {
        for my $i (0 .. $#$array)
        {
            next L_OUTER if $array->[ $i ] == $m;
        }

        push @missing, $m;
    }

    return \@missing;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $input, $expected) = split / \| /x, $line;

        my @array   = split / , \s* /x, $input;
        my $missing = find_missing_numbers( \@array );
        my $got     = join ',', @$missing;

        is $got, $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1| 0, 1, 3          |2
Example 2| 0, 1             |2
Multi    | 0, 1, 3, 5, 9, 10|2,4,6
Negatives|-4,-3,-5, 4       |0,1,2,3
Single   | 0                |1
Evens    | 1, 3, 5, 7       |0,2,4
