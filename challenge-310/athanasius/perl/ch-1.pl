#!perl

################################################################################
=comment

Perl Weekly Challenge 310
=========================

TASK #1
-------
*Arrays Intersection*

Submitted by: Mohammad Sajid Anwar

You are given a list of array of integers.

Write a script to return the common elements in all the arrays.

Example 1

  Input: $list = ( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] )
  Output: (1, 4)

Example 2

  Input: $list = ( [1, 0, 2, 3], [2, 4, 5] )
  Output: (2)

Example 3

  Input: $list = ( [1, 2, 3], [4, 5], [6] )
  Output: ()

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of strings is entered on the command-line. Each string is a list of
   integers, separated by whitespace.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<list> ...]
  perl $0

    [<list> ...]    A list of space-separated integer-array strings
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 310, Task #1: Arrays Intersection (Perl)\n\n";
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
        my $arrays = parse_input_list( \@ARGV );

        printf "Input:  \$list = ( %s )\n",
                join ', ', map { '[' . join( ', ', @$_ ) . ']' } @$arrays;

        my $intersection = find_intersection( $arrays );

        printf "Output: (%s)\n", join ', ', @$intersection;
    }
}

#-------------------------------------------------------------------------------
sub find_intersection
#-------------------------------------------------------------------------------
{
    my ($list) = @_;
    my  %int_count;

    for my $ints (@$list)
    {
        my %local_count;
         ++$local_count{ $_ } for @$ints;

         ++$int_count{ $_ } for keys %local_count;
    }

    my $n = scalar @$list;

    my @common = sort { $a <=> $b }
                 grep { $int_count{ $_ } == $n } keys %int_count;

    return \@common;
}

#-------------------------------------------------------------------------------
sub parse_input_list
#-------------------------------------------------------------------------------
{
    my ($list) = @_;
    my  @arrays;

    for my $array_str (@$list)
    {
        my @array;

        $array_str =~ s/ ^ \s+   //x;
        $array_str =~ s/   \s+ $ //x;

        for (split / \s+ /x, $array_str)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );

            push @array, $_;
        }

        push @arrays, \@array;
    }

    return \@arrays;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $list_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $list_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @list         = split / \; /x,  $list_str;
        my $arrays       = parse_input_list(  \@list );
        my $intersection = find_intersection( $arrays );
        my @expected     = split / \s+ /x, $exp_str;

        is_deeply $intersection, \@expected, $test_name;
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
Example 1|1 2 3 4; 4 5 6 1; 4 2 1 3|1 4
Example 2|1 0 2 3; 2 4 5           |2
Example 3|1 2 3;   4 5;     6      |
