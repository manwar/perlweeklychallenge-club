#!perl

################################################################################
=comment

Perl Weekly Challenge 373
=========================

TASK #2
-------
*List Division*

Submitted by: Mark Anderson

You are given a list and a non-negative integer.

Write a script to divide the given list into given non-negative integer equal 
parts. Return -1 if the integer is more than the size of the list.

Example 1

  Input: @list = (1,2,3,4,5), $n = 2
  Output: ((1,2,3), (4,5))

  5 / 2 = 2 remainder 1.
  The extra element goes into the first chunk.

Example 2

  Input: @list = (1,2,3,4,5,6), $n = 3
  Output: ((1,2), (3,4), (5,6))

  6 / 3 = 2 remainder 0.

Example 3

  Input: @list = (1,2,3), $n = 2
  Output: ((1,2), (3))

Example 4

  Input: @list = (1,2,3,4,5,6,7,8,9,10), $n = 5
  Output: ((1,2), (3,4), (5,6), (7,8), (9,10))

Example 5

  Input: @list = (1,2,3), $n = 4
  Output: -1

Example 6

  Input: @list = (72,57,89,55,36,84,10,95,99,35), $n = 7;
  Output: ((72,57), (89,55), (36,84), (10), (95), (99), (35))

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. The members of @list are unsigned integers.
2. @list has at least one member.
3. $n is greater than zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A positive (i.e., greater than zero) integer is entered on the command-line,
   followed by a non-empty list of unsigned integers.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Devel::Assert  qw( on );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <n> [<list> ...]
  perl $0

    <n>             Divisor: a positive integer
    [<list> ...]    A non-empty list of unsigned integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 373, Task #2: List Division (Perl)\n\n";
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
    elsif ($argc == 1)
    {
        error( 'Expected 0 or 2+ command-line arguments, found 1' );
    }
    else
    {
        my ($n, @list) = @ARGV;

        for my $i ($n, @list)
        {
            $i =~ / ^ $RE{num}{int} $ /x
                    or error( qq["$i" is not a valid integer] );

            $i >= 0 or error( "$i is negative");
        }

        $n == 0    and error( '$n is 0' );

        printf "Input:  \@list = (%s), \$n = %d\n", join( ',', @list ), $n;

        my $division = divide_list( $n, \@list );

        if (defined $division)
        {
            my @list_strs = map { '(' . join( ',', @$_ ) . ')' } @$division;

            printf "Output: (%s)\n", join ', ', @list_strs;
        }
        else
        {
            print  "Output: -1\n";
        }
    }
}

#-------------------------------------------------------------------------------
sub divide_list
#-------------------------------------------------------------------------------
{
    my ($n, $list) = @_;
    my  $list_size = scalar @$list;
    my  $division;

    if ($n <= $list_size)
    {
        my $quotient  = int( $list_size / $n );
        my $remainder =      $list_size % $n;

        for my $i (1 .. $n)
        {
            my   @sublist;
            push @sublist, shift @$list for 1 .. $quotient;

            if ($remainder > 0)
            {
                push @sublist, shift @$list;
                --$remainder;
            }

            push @$division, \@sublist;
        }

        assert $remainder        ==  0;
        assert scalar @$list     ==  0;
        assert scalar @$division == $n;
    }

    return $division;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $list_str, $n, @exp_strs) = split / \| /x, $line;

        for ($test_name, $list_str, $n, @exp_strs)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @list = split / \s+ /x, $list_str;

        my $division = divide_list( $n, \@list );

        if (defined $division)
        {
            my @expected = map { [ split / \s+ /x ] } @exp_strs;

            is_deeply $division, \@expected, $test_name;
        }
        else
        {
            ok scalar @exp_strs == 1 && $exp_strs[0] eq '-1', $test_name;
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
Example 1| 1  2  3  4  5               |2| 1  2 3| 4  5
Example 2| 1  2  3  4  5  6            |3| 1  2  | 3  4| 5  6
Example 3| 1  2  3                     |2| 1  2  | 3
Example 4| 1  2  3  4  5  6  7  8  9 10|5| 1  2  | 3  4| 5  6| 7  8| 9 10
Example 5| 1  2  3                     |4|-1
Example 6|72 57 89 55 36 84 10 95 99 35|7|72 57  |89 55|36 84|10|95|99|35
