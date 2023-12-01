#!perl

################################################################################
=comment

Perl Weekly Challenge 244
=========================

TASK #1
-------
*Count Smaller*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to calculate the number of integers smaller than the integer at
each index.

Example 1

  Input: @int = (8, 1, 2, 2, 3)
  Output: (4, 0, 1, 1, 3)

  For index = 0, count of elements less 8 is 4.
  For index = 1, count of elements less 1 is 0.
  For index = 2, count of elements less 2 is 1.
  For index = 3, count of elements less 2 is 1.
  For index = 4, count of elements less 3 is 3.

Example 2

  Input: @int = (6, 5, 4, 8)
  Output: (2, 1, 0, 3)

Example 3

  Input: @int = (2, 2, 2)
  Output: (0, 0, 0)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use v5.32.1;        # Enables strictures
use warnings;
use Const::Fast;
use List::MoreUtils qw( first_index );
use Regexp::Common  qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<int> ...]
  perl $0

    [<int> ...]    A list of integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 244, Task #1: Count Smaller (Perl)\n\n";
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
        my @int = @ARGV;

        for (@int)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        }

        printf "Input:  \@int = (%s)\n", join ', ', @int;

        my $out = count_smaller( \@int );

        printf "Output:        (%s)\n",  join ', ', @$out;
    }
}

#-------------------------------------------------------------------------------
sub count_smaller
#-------------------------------------------------------------------------------
{
    my  ($ints)  = @_;
    my   @sorted = sort { $a <=> $b } @$ints;
    my   @out;

    for my $int (@$ints)
    {
        push @out, first_index { $_ == $int } @sorted;
    }

    return \@out;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $int_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @int = split / \s+ /x, $int_str;
        my $out = count_smaller( \@int );
        my @exp = split / \s+ /x, $exp_str;

        is_deeply $out, \@exp, $test_name;
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
Example 1|8 1 2 2 3|4 0 1 1 3
Example 2|6 5 4 8  |2 1 0 3
Example 3|2 2 2    |0 0 0
