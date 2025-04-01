#!perl

################################################################################
=comment

Perl Weekly Challenge 314
=========================

TASK #2
-------
*Sort Column*

Submitted by: Mohammad Sajid Anwar

You are given a list of strings of same length.

Write a script to make each column sorted lexicographically by deleting any non
sorted columns.

Return the total columns deleted.

Example 1

  Input: @list = ("swpc", "tyad", "azbe")
  Output: 2

  swpc
  tyad
  azbe

  Column 1: "s", "t", "a" => non sorted
  Column 2: "w", "y", "z" => sorted
  Column 3: "p", "a", "b" => non sorted
  Column 4: "c", "d", "e" => sorted

  Total columns to delete to make it sorted lexicographically.

Example 2

  Input: @list = ("cba", "daf", "ghi")
  Output: 1

Example 3

  Input: @list = ("a", "b", "c")
  Output: 0

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
2. A non-empty list of same-length strings is entered on the command-line.

=cut
#===============================================================================

use v5.32;        # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<list> ...]
  perl $0

    [<list> ...]    A non-empty list of same-length strings
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 314, Task #2: Sort Column (Perl)\n\n";
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
        my @list = @ARGV;

        length == length $list[ 0 ] or error( 'Ragged list' ) for @list;

        printf "Input:  \@list = (%s)\n", join ', ', map { qq["$_"] } @list;

        my $deleted = count_deleted_columns( \@list );

        print  "Output: $deleted\n";
    }
}

#-------------------------------------------------------------------------------
sub count_deleted_columns
#-------------------------------------------------------------------------------
{
    my ($list) = @_;

    scalar @$list > 0             or error( 'Empty list'  );
    length == length $list->[ 0 ] or error( 'Ragged list' ) for @$list;

    my $deleted = 0;
    my @columns;

    for my $str (@$list)
    {
        my @chars = split //, $str;

        $columns[ $_ ] .= $chars[ $_ ] for 0 .. $#chars;
    }

    for (@columns)
    {
        ++$deleted unless is_sorted( $_ );
    }

    return $deleted;
}

#-------------------------------------------------------------------------------
sub is_sorted
#-------------------------------------------------------------------------------
{
    my ($string) = @_;
    my  @chars   = split //, $string;
    my  @sorted  = sort @chars;
    my  $sorted  = join '',  @sorted;

    return $string eq $sorted;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $list_str, $expected) = split / \| /x, $line;

        for ($test_name, $list_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @list    = split / \s+ /x, $list_str;
        my $deleted = count_deleted_columns( \@list );

        is $deleted, $expected, $test_name;
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
Example 1  |swpc  tyad  azbe |2
Example 2  |cba   daf   ghi  |1
Example 3  |a     b     c    |0
All deleted|fghij abcde vwxyz|5
