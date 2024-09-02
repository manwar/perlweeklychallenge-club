#!perl

################################################################################
=comment

Perl Weekly Challenge 284
=========================

TASK #2
-------
*Relative Sort*

Submitted by: Mohammad Sajid Anwar

You are given two list of integers, @list1 and @list2. The elements in the
@list2 are distinct and also in the @list1.

Write a script to sort the elements in the @list1 such that the relative order
of items in @list1 is same as in the @list2. Elements that is missing in @list2
should be placed at the end of @list1 in ascending order.

Example 1

  Input: @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)
         @list2 = (2, 1, 4, 3, 5, 6)
  Output: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)

Example 2

  Input: @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3)
         @list2 = (1, 3, 2)
  Output: (1, 3, 3, 3, 2, 2, 4, 4, 6)

Example 3

  Input: @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1)
         @list2 = (1, 0, 3, 2)
  Output: (1, 1, 1, 0, 0, 3, 2, 4, 5)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings are entered on the command-line. Each string contains a list of
   integers separated by whitespace. The integers in the second list are unique
   within that list, and each is also an element of the first list.

=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
use Const::Fast;
use List::Util     qw( any );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <list1> <list2>
  perl $0

    <list1>    String of whitespace-separated integers
    <list2>    String of whitespace-separated distinct integers also in list1
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 284, Task #2: Relative Sort (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 2)
    {
        my ($list1, $list2) = parse_command_line();

        printf "Input: \@list1 = (%s)\n", join ', ', @$list1;
        printf "       \@list2 = (%s)\n", join ', ', @$list2;

        my $sorted = relative_sort( $list1, $list2 );

        printf "Output:         (%s)\n",  join ', ', @$sorted;
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub relative_sort
#-------------------------------------------------------------------------------
{
    my ($list1, $list2) = @_;
    my (@sorted, @missing);
    my  %dict;

    for my $n (@$list1)
    {
        if (any { $_ == $n } @$list2)
        {
            ++$dict{ $n };
        }
        else
        {
            push @missing, $n;
        }
    }

    for my $m (@$list2)
    {
        push @sorted, $m for 1 .. $dict{ $m };
    }

    push @sorted, sort { $a <=> $b } @missing;

    return \@sorted;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($list1, $list2) = @ARGV;
    my (@list1, @list2);

    trim_strs( $list1, $list2 );

    for my $s (split / \s+ /x, $list1)
    {
        $s =~ / ^ $RE{num}{int} $ /x
            or error( qq["$s" is not a valid integer] );

        push @list1, $s + 0;                   # Normalize $s
    }

    my %dict1;
     ++$dict1{ $_ } for @list1;

    for my $t (split / \s+ /x, $list2)
    {
        $t =~ / ^ $RE{num}{int} $ /x
            or error( qq["$t" is not a valid integer] );

        push @list2, $t + 0;                   # Normalize $t
    }

    my %dict2;
     ++$dict2{ $_ } for @list2;

    for my $n (@list2)
    {
        $dict2{ $n } == 1   or error( "Element $n is not unique in \@list2"  );
        exists $dict1{ $n } or error( "\@list2 element $n is not in \@list1" );
    }

    return (\@list1, \@list2);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $list1_str, $list2_str, $expected_str) =
             split / \| /x, $line;

        trim_strs( $test_name, $list1_str, $list2_str, $expected_str );

        my @list1    = split / \s+ /x, $list1_str;
        my @list2    = split / \s+ /x, $list2_str;
        my @expected = split / \s+ /x, $expected_str;
        my $sorted   = relative_sort( \@list1, \@list2 );

        is_deeply $sorted, \@expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub trim_strs
#-------------------------------------------------------------------------------
{
    for (@_)
    {
        s/ ^ \s+   //x;
        s/   \s+ $ //x;
    }
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
Example 1|2 3 9 3 1 4 6 7 2 8 5|2 1 4 3 5 6|2 2 1 4 3 3 5 6 7 8 9
Example 2|3 3 4 6 2 4 2 1 3    |1 3 2      |1 3 3 3 2 2 4 4 6
Example 3|3 0 5 0 2 1 4 1 1    |1 0 3 2    |1 1 1 0 0 3 2 4 5
