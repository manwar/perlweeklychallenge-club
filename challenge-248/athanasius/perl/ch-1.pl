#!perl

################################################################################
=comment

Perl Weekly Challenge 248
=========================

TASK #1
-------
*Shortest Distance*

Submitted by: Mohammad S Anwar

You are given a string and a character in the given string.

Write a script to return an array of integers of size same as length of the
given string such that:

  distance[i] is the distance from index i to the closest occurence of
  the given character in the given string.

  The distance between two indices i and j is abs(i - j).

Example 1

  Input: $str = "loveleetcode", $char = "e"
  Output: (3,2,1,0,1,0,0,1,2,2,1,0)

  The character 'e' appears at indices 3, 5, 6, and 11 (0-indexed).
  The closest occurrence of 'e' for index 0 is at index 3, so the distance is
  abs(0 - 3) = 3.
  The closest occurrence of 'e' for index 1 is at index 3, so the distance is
  abs(1 - 3) = 2.
  For index 4, there is a tie between the 'e' at index 3 and the 'e' at index 5,
  but the distance is still the same: abs(4 - 3) == abs(4 - 5) = 1.
  The closest occurrence of 'e' for index 8 is at index 6, so the distance is
  abs(8 - 6) = 2.

Example 2

  Input: $str = "aaab", $char = "b"
  Output: (3,2,1,0)

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

Algorithm
---------
1. Create an array @min_dist of shortest distances, initially all empty.
2. Assign 0 to each element of @min_dist corresponding to the target character.
3. Assign 1 to each *empty* element of @min_dist that is immediately adjacent to
   an element containing 0.
4. Assign 2 to each *empty* element of @min_dist that is immediately adjacent to
   an element containing 1.
5. Repeat for 3, 4, 5, ... until no elements of @min_dist are empty.

Note: this algorithm does not require any measurement of distances

=cut
#===============================================================================

use v5.32.1;   # Enables strictures
use warnings;
use Const::Fast;
use List::Util qw( all min );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 <str> <char>
  perl $0

    <str>     A string of one or more characters
    <char>    A character in the given string\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 248, Task #1: Shortest Distance (Perl)\n\n";
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
        my ($str, $char) = @ARGV;

        $str =~ /$char/ or error( qq[The given character "$char" does not ] .
                                    'appear in the given string' );

        print qq[Input:  \$str = "$str", \$char = "$char"\n];

        my ($min_dist) = find_shortest_distances( $str, $char );

        printf "Output: (%s)\n", join ',', @$min_dist;
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_shortest_distances
#-------------------------------------------------------------------------------
{
    my ($str, $char) = @_;
    my  @str_char    =  split //, $str;
    my  @min_dist    = (undef) x scalar @str_char;

    for my $i (0 .. $#str_char)
    {
        $min_dist[ $i ] = 0 if $str_char[ $i ] eq $char;
    }

    my $target = 0;

    until (all { defined $_ } @min_dist)
    {
        for my $i (0 .. $#str_char)
        {
            next unless defined $min_dist[ $i ] && $target == $min_dist[ $i ];

            $min_dist[ $i - 1 ] = $target + 1
                if $i > 0          && !defined $min_dist[ $i - 1 ];

            $min_dist[ $i + 1 ] = $target + 1
                if $i < $#str_char && !defined $min_dist[ $i + 1 ];
        }

        ++$target;
    }

    return \@min_dist;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $char, $exp_str) = split / \| /x, $line;

        for ($test_name, $str, $char, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my ($sd) = find_shortest_distances( $str, $char );
        my  @exp = split / \s+ /x, $exp_str;

        is_deeply $sd, \@exp, $test_name;
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
Example 1|loveleetcode|e|3 2 1 0 1 0 0 1 2 2 1 0
Example 2|aaab        |b|3 2 1 0
