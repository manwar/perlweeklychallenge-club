#!perl

################################################################################
=comment

Perl Weekly Challenge 222
=========================

TASK #2
-------
*Last Member*

Submitted by: Mohammad S Anwar

You are given an array of positive integers, @ints.

Write a script to find the last member if found otherwise return 0. Each turn
pick 2 biggest members (x, y) then decide based on the following conditions,
continue this until you are left with 1 member or none.

    a) if x == y then remove both members

    b) if x != y then remove both members and add new member (y-x)

Example 1:

  Input: @ints = (2, 7, 4, 1, 8, 1)
  Output: 1

  Step 1: pick 7 and 8, we remove both and add new member 1 => (2, 4, 1, 1, 1).
  Step 2: pick 2 and 4, we remove both and add new member 2 => (2, 1, 1, 1).
  Step 3: pick 2 and 1, we remove both and add new member 1 => (1, 1, 1).
  Step 4: pick 1 and 1, we remove both => (1).

Example 2:

  Input: @ints = (1)
  Output: 1

Example 3:

  Input: @ints = (1, 1)
  Output: 0

  Step 1: pick 1 and 1, we remove both and we left with none.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. A "positive integer" is an integer greater than zero.
2. Condition b) means: 
      if x < y then remove both members and add new member (y-x)
   -- so that the new member is always a positive integer.

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A list of positive integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 222, Task #2: Last Member (Perl)\n\n";
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
        my @ints = @ARGV;

        for (@ints)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
            $_ > 0                 or error( qq["$_" is not positive] );
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $last_member = find_last_member( \@ints );

        print "Output: $last_member\n";
    }
}

#-------------------------------------------------------------------------------
sub find_last_member
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @list  = sort { $a <=> $b } @$ints;

    while (scalar @list > 1)
    {
        my $y = pop @list;
        my $x = pop @list;

        if ($x < $y)
        {
            unshift @list, $y - $x;
            @list = sort { $a <=> $b } @list;
        }
    }

    return scalar @list ? $list[ 0 ] : 0;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expected) = split / \| /x, $line;

        for ($test_name, $ints_str, $expected)                 # Trim whitespace
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $ints_str;
        my $last = find_last_member( \@ints );

        is $last, $expected, $test_name;
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
Example 1|2 7 4 1 8 1|1
Example 2|1          |1
Example 3|1 1        |0
