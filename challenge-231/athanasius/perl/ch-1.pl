#!perl

################################################################################
=comment

Perl Weekly Challenge 231
=========================

TASK #1
-------
*Min Max*

Submitted by: Mohammad S Anwar

You are given an array of distinct integers.

Write a script to find all elements that is neither minimum nor maximum. Return
-1 if you can’t.

Example 1

  Input: @ints = (3, 2, 1, 4)
  Output: (3, 2)

  The minimum is 1 and maximum is 4 in the given array. So (3, 2) is neither min
  nor max.

Example 2

  Input: @ints = (3, 1)
  Output: -1

Example 3

  Input: @ints = (2, 1, 3)
  Output: (2)

  The minimum is 1 and maximum is 3 in the given array. So 2 is neither min nor
  max.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
An output of "-1" denotes "no elements found", but an output of "(-1)" (note the
parentheses) means the element -1 was found. Hence, negative integers are allow-
ed in the input list.

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use List::Util     qw( max min );
use Regexp::Common qw( number  );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<ints> ...]
  perl $0
    [<ints> ...]    A non-empty list of distinct integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 231, Task #1: Min Max (Perl)\n\n";
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
        my $ints  = parse_command_line();

        printf "Input:  \@ints = (%s)\n", join ', ', @$ints;

        my $inner = find_inner( $ints );

        printf "Output: %s\n",
                scalar( @$inner ) > 0 ? '(' . join( ', ', @$inner ) . ')'
                                      : '-1';
    }
}

#-------------------------------------------------------------------------------
sub find_inner
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  $max   = max @$ints;
    my  $min   = min @$ints;
    my  @inner;

    for my $int (@$ints)
    {
        push @inner, $int if $min < $int < $max;
    }

    return \@inner;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my %count;

    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x
                or error( qq["$_" is not a valid integer] );

        ++$count{ $_ };
    }

    for (values %count)
    {
        $_ == 1 or error( 'Duplicate found in the input list' );
    }

    return [ @ARGV ];
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

        my @ints  = split / \s+ /x, $int_str;
        my $inner = find_inner( \@ints );

        if ($exp_str)
        {
            my @exp = split / \s+ /x, $exp_str;

            is_deeply $inner, \@exp, $test_name;
        }
        else
        {
            is scalar( @$inner ), 0, $test_name;
        }
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
Example 1  | 3  2  1 4  | 3  2
Example 2  | 3  1       |
Example 3  | 2  1  3    | 2
Negatives 1|-5 -1 -3 0 2|-1 -3 0
Negatives 2|-2 -1  0    |-1
