#!perl

################################################################################
=comment

Perl Weekly Challenge 242
=========================

TASK #1
-------
*Missing Members*

Submitted by: Mohammad S Anwar

You are given two arrays of integers.

Write a script to find out the missing members in each other arrays.

Example 1

  Input: @arr1 = (1, 2, 3)
         @arr2 = (2, 4, 6)
  Output: ([1, 3], [4, 6])

  (1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
  (2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).

Example 2

  Input: @arr1 = (1, 2, 3, 3)
         @arr2 = (1, 1, 2, 2)
  Output: ([3])

  (1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2). Since
  they are same, keep just one.
  (1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).

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

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Set::Tiny      qw( set );
use Test::More;

const my $SEPARATOR => '*';
const my $USAGE     =>
qq[Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    Two lists of integers, separated by "*"\n];

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 242, Task #1: Missing Members (Perl)\n\n";
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
        my ($arr1, $arr2) = parse_command_line();

        printf "Input:  \@arr1 = (%s)\n", join ', ', @$arr1;
        printf "        \@arr2 = (%s)\n", join ', ', @$arr2;

        my ($out1, $out2) = find_missing_members( $arr1, $arr2 );

        printf "Output: ([%s], [%s])\n", join( ', ', @$out1 ),
                                         join  ', ', @$out2;
    }
}

#-------------------------------------------------------------------------------
sub find_missing_members
#-------------------------------------------------------------------------------
{
    my ($arr1, $arr2) = @_;

    my $set1  = set( $arr1 );
    my $set2  = set( $arr2 );
    my $inter = $set1->intersection( $set2 );
    my $out1  = $set1->difference( $inter );
    my $out2  = $set2->difference( $inter );
    my @out1  = sort { $a <=> $b } $out1->elements;
    my @out2  = sort { $a <=> $b } $out2->elements;

    return (\@out1, \@out2);
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $separators = 0;
    my $pivot;

    for my $i (0 .. $#ARGV)
    {
        if ($ARGV[ $i ] eq $SEPARATOR)
        {
            ++$separators;
            $pivot = $i;
        }
    }

    $separators == 0 and error( 'No separator character found' );
    $separators >  1 and error( 'More than one separator character found' );

    my @arr1 = @ARGV[ 0          .. $pivot - 1 ];
    my @arr2 = @ARGV[ $pivot + 1 .. $#ARGV     ];

    for (@arr1, @arr2)
    {
        / ^ $RE{num}{int} $ /x
                     or  error( qq["$_" is not a valid integer] );
    }

    return (\@arr1, \@arr2);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $arr1_str, $arr2_str, $exp1_str, $exp2_str) =
             split / \| /x, $line;

        for ($test_name, $arr1_str, $arr2_str, $exp1_str, $exp2_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @arr1 = split / \s+ /x, $arr1_str;
        my @arr2 = split / \s+ /x, $arr2_str;
        my @exp1 = split / \s+ /x, $exp1_str;
        my @exp2 = split / \s+ /x, $exp2_str;

        my ($out1, $out2) = find_missing_members( \@arr1, \@arr2 );

        is_deeply $out1, \@exp1, $test_name . ': array 1';
        is_deeply $out2, \@exp2, $test_name . ': array 2';
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
Example 1 | 1 2 3   | 2  4 6  | 1 3| 4 6
Example 2 | 1 2 3  3| 1  1 2 2| 3  |
Example 2a| 1 1 2  2| 1  2 3 3|    | 3
Negatives |-3 5 7 -1|-1 -2 0 5|-3 7|-2 0
