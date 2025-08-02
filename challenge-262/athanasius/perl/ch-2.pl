#!perl

################################################################################
=comment

Perl Weekly Challenge 262
=========================

TASK #2
-------
*Count Equal Divisible*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and an integer $k.

Write a script to return the number of pairs (i, j) where

  a) 0 <= i < j < size of @ints
  b) ints[i] == ints[j]
  c) i x j is divisible by k

Example 1

  Input: @ints = (3,1,2,2,2,1,3) and $k = 2
  Output: 4

  (0, 6) => ints[0] == ints[6] and 0 x 6 is divisible by 2
  (2, 3) => ints[2] == ints[3] and 2 x 3 is divisible by 2
  (2, 4) => ints[2] == ints[4] and 2 x 4 is divisible by 2
  (3, 4) => ints[3] == ints[4] and 3 x 4 is divisible by 2

Example 2

  Input: @ints = (1,2,3) and $k = 1
  Output: 0

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The divisor $k may take any integer value, positive or negative, except zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The divisor $k is given on the command-line as a named argument, followed by
   a (possibly empty) list of integers.
3. If any integer in the list (i.e., following $k) on the command-line is
   negative, the first such integer must be preceded by "--" to indicate that
   what follows does not contain command-line flags.
4. If the constant $VERBOSE is set to a true value, the output count is followed
   by a list of the (i, j) pairs themselves.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   => <<END;
Usage:
  perl $0 [-k[=Int]] [<ints> ...]
  perl $0

    -k[=Int]        The divisor: a non-zero integer
    [<ints> ...]    A list of integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 262, Task #2: Count Equal Divisible (Perl)\n\n";
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
        my ($k, $ints) = parse_command_line();

        printf "Input:  \@ints = (%s) and \$k = %d\n", join( ', ', @$ints ), $k;

        my $pairs = find_equal_divisible_pairs( $ints, $k );

        printf "Output: %d\n", scalar @$pairs;

        printf "\nPairs found: %s\n",
            join ', ', map { '(' . $_->[ 0 ] . ', ' . $_->[ 1 ] . ')' } @$pairs
                if $VERBOSE;
    }
}

#-------------------------------------------------------------------------------
sub find_equal_divisible_pairs
#-------------------------------------------------------------------------------
{
    my ($ints, $k) = @_;
    my  @pairs;

    for my $i (0 .. $#$ints - 1)
    {
        for my $j ($i + 1 .. $#$ints)
        {
            push @pairs,  [ $i, $j ]
                if $ints->[ $i ] == $ints->[ $j ] && ($i * $j) % $k == 0;
        }
    }

    return \@pairs;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $k;

    GetOptions( 'k=i' => \$k )
                           or  error( 'Invalid command-line argument' );

    defined $k             or  error( '$k is missing' );
    
    $k =~ / ^ $RE{num}{int} $ /x
                           or  error( qq[\$k ("$k") is not a valid integer] );

    $k == 0                and error( '$k is zero' );

    my @ints = @ARGV;

    / ^ $RE{num}{int} $ /x or  error( qq["$_" is not a valid integer] )
        for @ints;

    return ($k, \@ints);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $k_str, $expected) = split / \| /x, $line;

        for ($test_name, $ints_str, $k_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints  = split / \s+ /x, $ints_str;
        my $pairs = find_equal_divisible_pairs( \@ints, $k_str );

        is scalar( @$pairs ), $expected, $test_name;
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
Example 1      | 3  1 2  2  2  1  3| 2|4
Example 2      | 1  2 3            | 1|0
Negative $k 1  | 3  1 2  2  2  1  3|-1|5
Negative $k 2  | 3  1 2  2  2  1  3|-2|4
Negative ints 1|-3 -1 2 -2 -2 -1 -3| 2|2
Negative ints 2|-3 -1 2 -2 -2 -1 -3|-2|2
