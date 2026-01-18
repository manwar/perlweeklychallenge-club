#!perl

################################################################################
=comment

Perl Weekly Challenge 356
=========================

TASK #2
-------
*Who Wins*

Submitted by: Simon Green

It's NFL playoff time. Since the 2020 season, seven teams from each of the
league's two conferences (AFC and NFC) qualify for the playoffs based on regular
season winning percentage, with a tie-breaking procedure if required. The top
team in each conference receives a first-round bye, automatically advancing to
the second round.

The following games are played. Some times the games are played in a different
order. To make things easier, assume the order is always as below.

  - Week 1: Wild card playoffs
    - Team 1 gets a bye
    - Game 1: Team 2 hosts Team 7
    - Game 2: Team 3 hosts Team 6
    - Game 3: Team 4 hosts Team 5
  - Week 2: Divisional playoffs
    - Game 4: Team 1 hosts the third seeded winner from the previous week.
    - Game 5: The highest seeded winner from the previous week hosts the second
      seeded winner.
  - Week 3: Conference final
    - Game 6: The highest seeded winner from the previous week hosts the other
      winner

You are given a six character string containing only H (home) and A (away) which
has the winner of each game. Which two teams competed in the conference final
and who won?

Example 1

[ https://en.wikipedia.org/wiki/2024%E2%80%9325_NFL_playoffs#Bracket
|NFC Conference 2024/5]. Teams were Detroit, Philadelphia, Tampa Bay, Los
Angeles Rams, Minnesota, Washington and Green Bay. Philadelphia - seeded second
- won.

  Input: $results = "HAHAHH"
  Output: "Team 2 defeated Team 6"

  In Week 1, Team 2 (home) won against Team 7, Team 6 (away) defeated Team 3 and
  Team 4 (home) were victorious over Team 5. This means the second week match
  ups are Team 1 at home to Team 6, and Team 2 hosted Team 4.

  In week 2, Team 6 (away) won against Team 1, while Team 2 (home) beat Team 4.
  The final week was Team 2 hosting Team 6

  In the final week, Team 2 (home) won against Team 6.

Example 2

AFC Conference 2024/5. Teams were Kansas City, Buffalo, Baltimore, Houston, Los
Angeles Charges, Pittsburgh and Denver. Kansas City - seeded first - won.

  Input: $results = "HHHHHH"
  Output: "Team 1 defeated Team 2"

Example 3

[ https://en.wikipedia.org/wiki/2021%E2%80%9322_NFL_playoffs#Bracket
|AFC Conference 2021/2]. Teams were Tennessee, Kansas City, Buffalo, Cincinnati,
Las Vegas, New England and Pittsburgh. Cincinnati - seeded fourth - won.

  Input: $results = "HHHAHA"
  Output: "Team 4 defeated Team 2"

Example 4

NFC Conference 2021/2. Teams were Green Bay, Tampa Bay, Dallas, Los Angeles
Rams, Arizona, San Francisco and Philadelphia. The Rams - seeded fourth - won.

  Input: $results = "HAHAAH"
  Output: "Team 4 defeated Team 6"

Example 5

[ https://en.wikipedia.org/wiki/2020%E2%80%9321_NFL_playoffs#Bracket
|NFC Conference 2020/1. Teams were Green Bay, New Orleans, Seattle, Washington,
Tampa Bay, Los Angeles Rams and Chicago. Tampa Bay - seeded fifth - won.

  Input: $results = "HAAHAA"
  Output: "Team 5 defeated Team 1"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A six character string containing only the letters "H" and "A" is entered on
   the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <results>
  perl $0

    <results>    A 6-character string containing only the letters "H" and "A"
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 356, Task #2: Who Wins (Perl)\n\n";
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
        my $results =  $ARGV[0];
           $results =~ / ^ [AH]{6} $ /x or error( 'Invalid input string' );

        print qq[Input:  \$results = "$results"\n];

        my ($winner, $runner_up) = get_finalists( $results );

        print qq[Output: "Team $winner defeated Team $runner_up"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub get_finalists
#-------------------------------------------------------------------------------
{
    my ($results)  = @_;
    my  @results   = split //, $results;
    my  @week_1;
        $week_1[0] = $results[0] eq 'H' ? 2          : 7;
        $week_1[1] = $results[1] eq 'H' ? 3          : 6;
        $week_1[2] = $results[2] eq 'H' ? 4          : 5;
        @week_1    = sort { $a <=> $b } @week_1;
    my  @week_2;
        $week_2[0] = $results[3] eq 'H' ? 1          : $week_1[2];
        $week_2[1] = $results[4] eq 'H' ? $week_1[0] : $week_1[1];
        @week_2    = sort { $a <=> $b } @week_2;
    my  $winner    = $results[5] eq 'H' ? $week_2[0] : $week_2[1];
    my  $runner_up = $results[5] eq 'A' ? $week_2[0] : $week_2[1];

    return ($winner, $runner_up);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $results, $exp_winner, $exp_ru) = split / \| /x, $line;

        for ($test_name, $results, $exp_winner, $exp_ru)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my ($winner, $runner_up) = get_finalists( $results );

        ok  $winner == $exp_winner && $runner_up == $exp_ru, $test_name;
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
Example 1|HAHAHH|2|6
Example 2|HHHHHH|1|2
Example 3|HHHAHA|4|2
Example 4|HAHAAH|4|6
Example 5|HAAHAA|5|1
