#!perl

################################################################################
=comment

Perl Weekly Challenge 293
=========================

TASK #1
-------
*Similar Dominos*

Submitted by: Mohammad Sajid Anwar

You are given a list of dominos, @dominos.

Write a script to return the number of dominoes that are similar to any other
domino.

    $dominos[i] = [a, b] and $dominos[j] = [c, d] are same if either (a = c and
    b = d) or (a = d and b = c).

Example 1

  Input: @dominos = ([1, 3], [3, 1], [2, 4], [6, 8])
  Output: 2

  Similar Dominos: $dominos[0], $dominos[1]

Example 2

  Input: @dominos = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])
  Output: 3

  Similar Dominos: $dominos[0], $dominos[1], $dominos[3]

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
A spot can be any single digit.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of domino-strings is entered on the command-line. Each
   domino-string is a pair of single digits separated by a comma, with optional
   whitespace. E.g., "1, 3" "3, 0" "0, 2" "0, 0" "9, 4"

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<domino-strs> ...]
  perl $0

    [<domino-strs> ...]    A non-empty list of domino-strings, e.g., "1, 3"
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 293, Task #1: Similar Dominos (Perl)\n\n";
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
        my $dominoes = read_dominoes( \@ARGV );

        printf "Input:  \@dominoes = (%s)\n",
                join ', ', map { "[$_->[ 0 ], $_->[ 1 ]]" } @$dominoes;

        my $similar = find_similar_dominoes( $dominoes );

        print "Output: $similar\n";
    }
}

#-------------------------------------------------------------------------------
sub find_similar_dominoes
#-------------------------------------------------------------------------------
{
    my ($dominoes) = @_;
    my  %sets;

    while (@$dominoes)
    {    
        my $domino = shift @$dominoes;
        my $lhs    = $domino->[ 0 ];
        my $rhs    = $domino->[ 1 ];
        my $key    = $lhs <= $rhs ? "$lhs:$rhs" : "$rhs:$lhs";

        ++$sets{ $key };
    }

    my $similar = 0;

    for my $count (values %sets)
    {
        $similar += $count if $count > 1;
    }

    return $similar;
}

#-------------------------------------------------------------------------------
sub read_dominoes
#-------------------------------------------------------------------------------
{
    my ($domino_strs) = @_;
    my  @dominoes;

    for my $str (@$domino_strs)
    {
        $str =~ / ^ \s* (\d) \s* \, \s* (\d) \s* $ /x
                                   or error( qq[Invalid domino string "$str"] );

        my  ($lhs, $rhs) = ($1, $2);

        for ($lhs, $rhs)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );

            0 <= $_ <= 9           or error( qq[$_ is out of range] );
        }

        push @dominoes, [ $lhs, $rhs ];
    }

    return \@dominoes;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $domino_str, $expected) = split / \| /x, $line;

        for ($test_name, $domino_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @pairs    = split / \s* \; \s* /x, $domino_str;
        my $dominoes = read_dominoes( \@pairs );
        my $similar  = find_similar_dominoes( $dominoes );

        is $similar, $expected, $test_name;
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
Example 1|1, 3; 3, 1; 2, 4; 6, 8      |2
Example 2|1, 2; 2, 1; 1, 1; 1, 2; 2, 2|3
