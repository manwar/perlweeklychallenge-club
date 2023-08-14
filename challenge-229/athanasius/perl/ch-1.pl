#!perl

################################################################################
=comment

Perl Weekly Challenge 229
=========================

TASK #1
-------
*Lexicographic Order*

Submitted by: Mohammad S Anwar

You are given an array of strings.

Write a script to delete element which is not lexicographically sorted (forwards
or backwards) and return the count of deletions.

Example 1

  Input: @str = ("abc", "bce", "cae")
  Output: 1

  In the given array "cae" is the only element which is not lexicographically
  sorted.

Example 2

  Input: @str = ("yxz", "cba", "mon")
  Output: 2

  In the given array "yxz" and "mon" are not lexicographically sorted.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Lexicographic order is case-sensitive, and "Z" (upper case) < "a" (lower case).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value, the solution is followed by a list of the
   deleted elements.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $VERBOSE => 1;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 229, Task #1: Lexicographic Order (Perl)\n\n";
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
        my @str = @ARGV;

        printf "Input:  \@str = (%s)\n", join ', ', map { qq["$_"] } @str;

        my $deletions = delete_unsorted( \@str );
        my $del_count = scalar @$deletions;

        print "Output: $del_count\n";

        if ($VERBOSE)
        {
            printf "\nDeleted element%s: (%s)\n",
                    $del_count == 1 ? '' : 's',
                    join ', ', map { qq["$_"] } @$deletions;
        }
    }
}

#-------------------------------------------------------------------------------
sub delete_unsorted
#-------------------------------------------------------------------------------
{
    my ($strings) = @_;
    my  @deletions;

    for (@$strings)
    {
        my $asc  = join '', sort               split '';
        my $desc = join '', sort { $b cmp $a } split '';

        push @deletions, $_ unless $_ eq $asc || $_ eq $desc;
    }

    return \@deletions;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $string, $expected, $exp_str) = split / \| /x, $line;

        for ($test_name, $string, $expected, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @strings   = split / \s+ /x, $string;
        my @exp_strs  = split / \s+ /x, $exp_str;
        my $deletions = delete_unsorted( \@strings );
        my $del_count = scalar @$deletions;

        is        $del_count,  $expected, "$test_name: count";
        is_deeply $deletions, \@exp_strs, "$test_name: deletions";
    }

    done_testing;
}

################################################################################

__DATA__
Example 1|abc bce cae|1|cae
Example 2|yxz cba mon|2|yxz mon
Cases 1  |ABc AbC abC|2|AbC abC
Cases 2  |Zab jkp XYc|0|
