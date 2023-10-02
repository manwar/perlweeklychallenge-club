#!perl

################################################################################
=comment

Perl Weekly Challenge 229
=========================

TASK #2
-------
*Two out of Three*

Submitted by: Mohammad S Anwar

You are given three array of integers.

Write a script to return all the elements that are present in at least 2 out of
3 given arrays.

Example 1

  Input: @array1 = (1, 1, 2, 4)
         @array2 = (2, 4)
         @array3 = (4)
  Output: (2, 4)

Example 2

  Input: @array1 = (4, 1)
         @array2 = (2, 4)
         @array3 = (1, 2)
  Output: (1, 2, 4)

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

use strict;
use warnings;
use Const::Fast;
use List::Util     qw( uniqint );
use Regexp::Common qw( number  );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 <array1> <array2> <array3>
  perl $0

    <array1>    A string of comma-separated integers
    <array2>    A string of comma-separated integers
    <array3>    A string of comma-separated integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 229, Task #2: Two out of Three (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 3)
    {
        my $array1 = parse_int_str( $ARGV[ 0 ] );
        my $array2 = parse_int_str( $ARGV[ 1 ] );
        my $array3 = parse_int_str( $ARGV[ 2 ] );

        printf "Input:  \@array1 = (%s)\n", join ', ', @$array1;
        printf "        \@array2 = (%s)\n", join ', ', @$array2;
        printf "        \@array3 = (%s)\n", join ', ', @$array3;

        my $shared = find_shared_elements( $array1, $array2, $array3 );

        printf "Output: (%s)\n",            join ', ', @$shared;
    }
    else
    {
        error( "Expected 0 or 3 command-line arguments, found $args" );
    }
}

#-------------------------------------------------------------------------------
sub find_shared_elements
#-------------------------------------------------------------------------------
{
    my ($array1, $array2, $array3) = @_;
    my  @shared;
    my  %count;

    ++$count{ $_ }
        for uniqint( @$array1 ), uniqint( @$array2 ), uniqint( @$array3 );

    for my $key (keys %count)
    {
        push @shared, $key if $count{ $key } >= 2;
    }

    @shared = sort @shared;

    return \@shared;
}

#-------------------------------------------------------------------------------
sub parse_int_str
#-------------------------------------------------------------------------------
{
    my ($str)  = @_;
    my  @elems = split / \s* \, \s* /x, $str;
    my  @ints;

    for my $elem (@elems)
    {
        $elem =~ / ^ $RE{num}{int} $ /x
            or error( qq["$elem" is not a valid integer] );

        push @ints, $elem;
    }

    return \@ints;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $array1_str, $array2_str, $array3_str, $expctd_str) =
             split / \| /x, $line;

        for ($test_name, $array1_str, $array2_str, $array3_str, $expctd_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @array1 = split / \s+ /x, $array1_str;
        my @array2 = split / \s+ /x, $array2_str;
        my @array3 = split / \s+ /x, $array3_str;
        my @expctd = split / \s+ /x, $expctd_str;
        my $shared = find_shared_elements( \@array1, \@array2, \@array3 );

        is_deeply $shared, \@expctd, $test_name;
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
Example 1| 1 1 2 4   | 2   4        |4      | 2 4
Example 2| 4 1       | 2   4        |1  2   | 1 2 4
Negatives|-1 7 0 5 12|-5 -12 -1 17 4|0 32   |-1 0
Disjoint | 1 2 3 4   |-1  -2 -3 -4  |0  5 -5|
