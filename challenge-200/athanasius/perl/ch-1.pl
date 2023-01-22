#!perl

###############################################################################
=comment

Perl Weekly Challenge 200
=========================

TASK #1
-------
*Arithmetic Slices*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out all Arithmetic Slices for the given array of
integers.


    An integer array is called arithmetic if it has at least 3 elements and the
    differences between any three consecutive elements are the same.


Example 1

  Input: @array = (1,2,3,4)
  Output: (1,2,3), (2,3,4), (1,2,3,4)

Example 2

  Input: @array = (2)
  Output: () as no slice found.

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

Output Order
------------
As per Example 1, the slices are ordered by increasing size; slices of the same
size are preserved in the order in which they were found (scanning the array by
increasing indices). Note that the simple statement:

    @slices = sort { scalar @$a <=> scalar @$b } @slices;

is sufficient here because sorting in Perl has been stable since v5.8.0
(https://perldoc.perl.org/sort).

Note
----
In the case where the difference between consecutive elements is zero, the same
slice may appear multiple times in the output. For example, an input array of
(4,4,4,4) produces the output (4,4,4), (4,4,4), (4,4,4,4). I assume this is the
desired result.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $TEST_FIELDS => 3;
const my $USAGE       =>
"Usage:
  perl $0 [<array> ...]
  perl $0

    [<array> ...]    A list of 1 or more integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 200, Task #1: Arithmetic Slices (Perl)\n\n";
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
        my @array = @ARGV;

        for (@array)
        {
            / ^ $RE{num}{int} $ /x
                or die qq[ERROR: "$_" is not a valid integer\n$USAGE];
        }

        printf "Input:  \@array = (%s)\n", join ',', @array;

        my $slices = find_arithmetic_slices( \@array );

        printf "Output: %s\n", format_slices( $slices );
    }
}

#------------------------------------------------------------------------------
sub find_arithmetic_slices
#------------------------------------------------------------------------------
{
    my ($array) = @_;
    my  @slices;

    for my $i (0 .. $#$array - 2)
    {
        my $gap = $array->[ $i + 1 ] - $array->[ $i ];

        L_INNER:
        for my $j ($i + 2 .. $#$array)
        {
            if ($array->[ $j ] - $array->[ $j - 1 ] == $gap)
            {
                push @slices, [ (@$array)[ $i .. $j ] ];
            }
            else
            {
                last L_INNER;
            }
        }
    }

    @slices = sort { scalar @$a <=> scalar @$b } @slices;   # Sorting is stable

    return \@slices;
}

#------------------------------------------------------------------------------
sub format_slices
#------------------------------------------------------------------------------
{
    my ($slices) = @_;
    my  $gist    = '()';

    if (scalar @$slices > 0)
    {
        $gist = join ', ', map { '(' . join( ',', @$_ ) . ')' } @$slices;
    }

    return $gist;
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $input, $expected) = split /\|/, $line, $TEST_FIELDS;

        $input    =~ s/ ^ \s* (.+?) \s* $ /$1/x;              # Trim whitespace
        $expected =~ s/ ^ \s* (.+?) \s* $ /$1/x;
        $expected =~ s/   \s+             / /gx;

        my @array  = split / , \s* /x, $input;
        my $slices = find_arithmetic_slices( \@array );
        my $got    = format_slices( $slices );

        is $got, $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1 | 1,2,3,4         |(1,2,3), (2,3,4), (1,2,3,4)
Example 2 | 2               |()
Evens     | 1,2,4,6,8,9     |(2,4,6), (4,6,8), (2,4,6,8)
Odds      |-1,1,3,4,5,7,9,10|(-1,1,3), (3,4,5), (5,7,9)
Decreasing|10,7,4,3,2,1     |(10,7,4), (4,3,2), (3,2,1), (4,3,2,1)
Up & down |-1,1,3,2,1,0     |(-1,1,3), (3,2,1), (2,1,0), (3,2,1,0)
Unchanging| 0,42,42,42,42,17|(42,42,42), (42,42,42), (42,42,42,42)
