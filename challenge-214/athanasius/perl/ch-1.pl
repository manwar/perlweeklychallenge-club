#!perl

################################################################################
=comment

Perl Weekly Challenge 214
=========================

TASK #1
-------
*Rank Score*

Submitted by: Mohammad S Anwar

You are given a list of scores (>=1).

Write a script to rank each score in descending order. First three will get
medals i.e. G (Gold), S (Silver) and B (Bronze). Rest will just get the ranking
number.

    Using the standard model of giving equal scores equal rank, then advancing
    that number of ranks.

Example 1

  Input: @scores = (1,2,4,3,5)
  Output: (5,4,S,B,G)

  Score 1 is the 5th rank.
  Score 2 is the 4th rank.
  Score 4 is the 2nd rank i.e. Silver (S).
  Score 3 is the 3rd rank i.e. Bronze (B).
  Score 5 is the 1st rank i.e. Gold (G).

Example 2

  Input: @scores = (8,5,6,7,4)
  Output: (G,4,B,S,5)

  Score 8 is the 1st rank i.e. Gold (G).
  Score 5 is the 4th rank.
  Score 6 is the 3rd rank i.e. Bronze (B).
  Score 7 is the 2nd rank i.e. Silver (S).
  Score 4 is the 5th rank.

Example 3

  Input: @list = (3,5,4,2)
  Output: (B,G,S,4)

Example 4

  Input: @scores = (2,5,2,1,7,5,1)
  Output: (4,S,4,6,G,S,6)

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
use Regexp::Common qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<scores> ...]
  perl $0

    [<scores> ...]    A non-empty list of positive integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 214, Task #1: Rank Score (Perl)\n\n";
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
        my $scores = parse_command_line();

        printf "Input: \@scores = (%s)\n", join ',', @$scores;

        my $ranked = rank_scores( $scores );

        printf "Output:          (%s)\n",  join ',', @$ranked;
    }
}

#-------------------------------------------------------------------------------
sub rank_scores
#-------------------------------------------------------------------------------
{
    my ($scores) = @_;
    my  $ranks   = assign_ranks( $scores );
    my  @ranked;

    for my $score (@$scores)
    {
        my $rank = $ranks->{ $score };

        push @ranked, $rank == 1 ? 'G' :
                      $rank == 2 ? 'S' :
                      $rank == 3 ? 'B' : $rank; 
    }

    return \@ranked;
}

#-------------------------------------------------------------------------------
sub assign_ranks
#-------------------------------------------------------------------------------
{
    my ($scores)   = @_;
    my  @sorted    = sort { $b <=> $a } @$scores;
    my  $this_rank = 0;
    my  $next_rank = 1;
    my ($prev, %ranks);

    while (my $top = shift @sorted)
    {
        if (defined $prev && $prev == $top)
        {
            ++$next_rank;
        }
        else
        {
            $this_rank = $next_rank++;
        }

        $ranks{ $top } = $this_rank;
        $prev          = $top;
    }

    return \%ranks;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer]    );
        $_ > 0                 or error( qq["$_" is not a positive integer] );
    }

    return \@ARGV;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $scores, $expected) = split / \| /x, $line;

        s/ \s+ $ //x for $test_name, $scores;         # Trim whitespace

        my @expected = split / , /x, $expected;
        my @scores   = split / , /x, $scores;
        my $got      = rank_scores( \@scores );

        is_deeply $got, \@expected, $test_name;
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
Example 1|1,2,4,3,5    |5,4,S,B,G
Example 2|8,5,6,7,4    |G,4,B,S,5
Example 3|3,5,4,2      |B,G,S,4
Example 4|2,5,2,1,7,5,1|4,S,4,6,G,S,6
Long tie |3,1,3,3,3,3  |G,6,G,G,G,G
