#!perl

################################################################################
=comment

Perl Weekly Challenge 240
=========================

TASK #2
-------
*Build Array*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to create an array such that new[i] = old[old[i]] where 0 <= i <
new.length.

Example 1

  Input: @int = (0, 2, 1, 5, 3, 4)
  Output: (0, 1, 2, 4, 5, 3)

Example 2

  Input: @int = (5, 0, 1, 2, 3, 4)
  Output: (4, 5, 0, 1, 2, 3)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. All values in the input list are unsigned integers. 
2. For each i in the range 0 <= i < new.length, if j = old[i] is not in the same
   range (i.e., if j > new.length), then new[i] is undefined, which is displayed
   as "X" in the output list.

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use v5.32.1;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $UNDEF => 'X';
const my $USAGE =>
"Usage:
  perl $0 [<int> ...]
  perl $0

    [<int> ...]    A non-empty list of non-negative integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 240, Task #2: Build Array (Perl)\n\n";
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
            $_ >= 0                or error( qq["$_" is negative] );
        }

        printf "Input:  \@int = (%s)\n", join ', ', @int;

        my @new = build_array( \@int );

        printf "Output:        (%s)\n",  join ', ', map { $_ // $UNDEF } @new;
    }
}

#-------------------------------------------------------------------------------
sub build_array
#-------------------------------------------------------------------------------
{
    my ($int) = @_;
    my  @new  = (undef) x scalar @$int;

    for my $i (0 .. $#$int)
    {
        my $j = $int->[ $i ];

        $new[ $i ] = $int->[ $j ] if $j <= $#$int;
    }

    return @new;
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
        my @exp = split / \s+ /x, $exp_str;
        my @new = map { $_ // $UNDEF } build_array( \@int );

        is_deeply \@new, \@exp, $test_name;
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
Example 1|0 2 1 5 3 4|0 1 2 4 5 3
Example 2|5 0 1 2 3 4|4 5 0 1 2 3
Undefined|1 7 2      |7 X 2
