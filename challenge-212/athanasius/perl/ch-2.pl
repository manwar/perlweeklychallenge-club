#!perl

################################################################################
=comment

Perl Weekly Challenge 212
=========================

TASK #2
-------
*Rearrange Groups*

Submitted by: Mohammad S Anwar

You are given a list of integers and group size greater than zero.

Write a script to split the list into equal groups of the given size where
integers are in sequential order. If it can’t be done then print -1.

Example 1:

  Input: @list = (1,2,3,5,1,2,7,6,3) and $size = 3
  Output: (1,2,3), (1,2,3), (5,6,7)

Example 2:

  Input: @list = (1,2,3) and $size = 2
  Output: -1

Example 3:

  Input: @list = (1,2,4,3,5,3) and $size = 3
  Output: (1,2,3), (3,4,5)

Example 4:

  Input: @list = (1,5,2,6,4,7) and $size = 3
  Output: -1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If negative numbers are included in @list, they must be preceded by '--'.

Algorithm
---------
Given: M, a multiset of integers of size m = |M|; and
       s, an integer > 0.

Task:  Partition M into (m/s) groups, of equal size s, such that the elements of
       each group can be arranged in sequential order.

Solution:
(1) If s > m or s does not evenly divide m, output -1 as there is no solution.
    Otherwise:
(2) Remove the smallest element e from M and place it in the first group. Then
    remove an element f=e+1 from M and add it to group 1; and so on (element g=
          e+2, etc.) until the first group is filled (i.e., of size s).
(3) Repeat this process for the remaining groups, until M is empty.
(4) If at any point the required element is not found in M, immediately output
    -1 as there is no solution. Otherwise:
(5) Output all the groups constructed in (2) and (3). Since the order of the
    groups does not matter, this is the unique solution.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;
use List::Util     qw( min );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [--size[=Pos]] [<list> ...]
  perl $0

    --size[=Pos]    Size of each group
    [<list> ...]    A list of integers

    where Pos is an integer > 0\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 212, Task #2: Rearrange Groups (Perl)\n\n";
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
        my ($size, $list) = parse_command_line();

        printf "Input:  \@list = (%s) and \$size = %d\n",
            join( ',', @$list ), $size;

        my $groups = rearrange_groups( $list, $size );

        printf "Output: %s\n", scalar @$groups == 0 ? '-1' :
                join( ', ', map { '(' . join( ',', @$_ ) . ')' } @$groups );
    }
}

#-------------------------------------------------------------------------------
sub rearrange_groups
#-------------------------------------------------------------------------------
{
    my ($list, $size) = @_;
    my  $elements     = scalar @$list;
    my  @groups;

    if ($size <= $elements && $elements % $size == 0)
    {
        my %ints;
         ++$ints{ $_ } for @$list;

        while (%ints)
        {
            my $smallest  = min keys %ints;
            my @partition = $smallest;

            delete $ints{ $smallest } if --$ints{ $smallest } == 0;

            for my $inc (1 .. $size - 1)
            {
                my $next = $smallest + $inc;

                return [] unless exists $ints{ $next };

                push @partition, $next;

                delete $ints{ $next } if --$ints{ $next } == 0;
            }

            push @groups, \@partition;
        }
    }

    return \@groups;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $size;

    GetOptions( 'size=i' => \$size )
                               or error( 'Invalid command line arguments' );

    defined $size              or error( 'Missing size' );

    $size =~ / ^ $RE{num}{int} $ /x
                               or error( qq["$size" is not a valid integer] );

    $size > 0                  or error( qq["$size" is not positive] );

    my @list = @ARGV;

    scalar @list > 0           or error( 'Empty list' );

    for (@list)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
    }

    return ($size, \@list);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $list, $size, $output) = split / \| /x, $line;

        for ($test_name, $list, $size)            # Trim whitespace
        {
            s/ ^ \s+       //x;
            s/   \s+ \s* $ //x;
        }

        my @ints   = split / , \s* /x, $list;
        my $groups = rearrange_groups( \@ints, $size );
        my @expected;

        if ($output ne '-1')
        {
            my   @group_strs = ($output =~ / \,? \( .+? \) /gx);

            for (@group_strs)                     # Trim whitespace
            {
                s/ ^ \,? \(   //x;
                s/       \) $ //x;

                push @expected, [ split / , /x ];
            }
        }

        is_deeply $groups, \@expected, $test_name;
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
Example 1 | 1, 2, 3, 5, 1, 2,7,6,3|3|(1,2,3),(1,2,3),(5,6,7)
Example 2 | 1, 2, 3               |2|-1
Example 3 | 1, 2, 4, 3, 5, 3      |3|(1,2,3),(3,4,5)
Example 4 | 1, 5, 2, 6, 4, 7      |3|-1
Negatives |-7,-5,-6,-2,-3,-1      |3|(-7,-6,-5),(-3,-2,-1)
Mixed     | 1,-8, 0,-9            |2|(-9,-8),(0,1)
All in one| 6, 3, 5, 1, 4, 2      |6|(1,2,3,4,5,6)
Singles   |-2, 3,-1,-1, 2, 7      |1|(-2),(-1),(-1),(2),(3),(7)
