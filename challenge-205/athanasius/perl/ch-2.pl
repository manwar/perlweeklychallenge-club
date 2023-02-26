#!perl

###############################################################################
=comment

Perl Weekly Challenge 205
=========================

TASK #2
-------
*Maximum XOR*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find the highest value obtained by XORing any two distinct
members of the array.

Example 1

  Input: @array = (1,2,3,4,5,6,7)
  Output: 7

  The maximum result of 1 xor 6 = 7.

Example 2

  Input: @array = (2,4,1,3)
  Output: 7

  The maximum result of 4 xor 3 = 7.

Example 3

  Input: @array = (10,5,7,12,8)
  Output: 15

  The maximum result of 10 xor 5 = 15.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value, then the output is augmented with an
   explanation of how the result was obtained.

Assumption
----------
The elements of the input array are *non-negative* integers only, as shown in
the examples.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<array> ...]
  perl $0

    [<array> ...]    A list of non-negative integers, at least 2 distinct\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 205, Task #2: Maximum XOR (Perl)\n\n";
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
        my $array = parse_command_line();

        printf "Input:  \@array = (%s)\n", join ',', @$array;

        my ($xor, $a, $b) = find_xor_max( $array );

        print "Output: $xor\n";

        if ($VERBOSE)
        {
            my $len_a = length sprintf '%b', $a;
            my $len_b = length sprintf '%b', $b;
            my $width = ($len_a >= $len_b) ? $len_a : $len_b;

            printf "\nThe maximum result of %*d xor %*d = %*d\n",
               $width, $a, $width, $b, $width, $xor;

            printf "             (binary: %0*b xor %0*b = %0*b)\n",
               $width, $a, $width, $b, $width, $xor;
        }
    }
}

#------------------------------------------------------------------------------
sub find_xor_max
#------------------------------------------------------------------------------
{
    my ($array) = @_;

    my %freq;
     ++$freq{ $_ } for @$array;

    my @ordered = sort { $a <=> $b } keys %freq;

    scalar @ordered >= 2
        or error( 'The input array does not contain 2 distinct members' );

    my  $xor_max = -1;
    my ($a_max, $b_max);

    for my $i (0 .. $#ordered - 1)
    {
        my $aa = $ordered[ $i ];

        for my $j ($i + 1 .. $#ordered)
        {
            my $bb  = $ordered[ $j ];
            my $xor = $aa ^ $bb;

            if ($xor > $xor_max)
            {
                $xor_max = $xor;
                $a_max   = $aa;
                $b_max   = $bb;
            }
        }
    }

    return ($xor_max, $a_max, $b_max);
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args >= 2 or error( 'Expected at least 2 command-line arguments, ' .
                            "found $args" );

    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x
                  or error( qq["$_" is not a valid integer] );

        $_ >= 0   or error( qq["$_" is negative] );
    }

    return [ @ARGV ];
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

        my @array = split / \, \s* /x, $input;
        my $got   = (find_xor_max( \@array ))[ 0 ];

        is $got, $expected, $test_name;
    }

    done_testing;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

__DATA__
Example 1| 1, 2, 3,  4, 5, 6, 7|7
Example 2| 2, 4, 1,  3         |7
Example 3|10, 5, 7, 12, 8      |15
