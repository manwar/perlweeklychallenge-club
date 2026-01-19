#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 356 Task 2  Who Wins
#=============================================================================
# It’s NFL playoff time. Since the 2020 season, seven teams from each of
# the league’s two conferences (AFC and NFC) qualify for the playoffs based
# on regular season winning percentage, with a tie-breaking procedure if
# required. The top team in each conference receives a first-round bye,
# automatically advancing to the second round.
#
# The following games are played. Some times the games are played in a
# different order. To make things easier, assume the order is always as below.
#
# Week 1: Wild card playoffs
#       - Team 1 gets a bye
#       - Game 1: Team 2 hosts Team 7
#       - Game 2: Team 3 hosts Team 6
#       - Game 3: Team 4 hosts Team 5
# Week 2: Divisional playoffs
#       - Game 4: Team 1 hosts the third seeded winner from the previous week.
#       - Game 5: The highest seeded winner from the previous week hosts the
#                 second seeded winner.
# Week 3: Conference final
#      - Game 6: The highest seeded winner from the previous week hosts the
#        other winner
#
# You are given a six character string containing only H (home) and A away
# which has the winner of each game. Which two teams competed in the the
# conference final and who won?
#
# Example 1 NFC Conference 2024/5. Teams were Detroit, Philadelphia,
#           Tampa Bay, Los Angeles Rams, Minnesota, Washington and Green Bay.
#           Philadelphia - seeded second - won.
#       Input: $results = "HAHAHH"
#       Output: "Team 2 defeated Team 6"
#
# In Week 1, Team 2 (home) won against Team 7, Team 6 (away) defeated Team 3
# and Team 4 (home) were victorious over Team 5. This means the second week
# match ups are Team 1 at home to Team 6, and Team 2 hosted Team 4.
# In week 2, Team 6 (away) won against Team 1, while Team 2 (home) beat Team 4.
# The final week was Team 2 hosting Team 6
# In the final week, Team 2 (home) won against Team 6.
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say whoWins($_) for @ARGV;

#=============================================================================
sub whoWins($results)
{
    use List::Util qw/min max/;
    my @game = (0,0,0,0,0,0,0);

    # Arrange games with home team in index 0, away in index 1
    # Use 1-based indexing, put dummy value in [0]
    my @winner = (0, split(//, $results =~ tr/HA/01/r));

    # Week 1:
    $game[1] = (2,7)[$winner[1]];
    $game[2] = (3,6)[$winner[2]];
    $game[3] = (4,5)[$winner[3]];

    # Arrange winners in order by seeding
    my @week2 = sort { $a <=> $b} @game[1,2,3];

    # 1(bye) vs. lowest-seeded winner
    $game[4] = (1, pop @week2)[$winner[4]];
    # Other two teams, higher seed gets home
    $game[5] = (@week2)[$winner[5]];

    # Highest-seeded remaining team gets to be home
    my @week3 = ( min(@game[4,5]), max(@game[4,5]) );
    my $champion = $week3[  $winner[6]      ];
    my $loser    = $week3[ ($winner[6]+1)%2 ];

    return "Team $champion defeated Team $loser";
}

sub runTest
{
    use Test2::V0;

    is( whoWins("HAHAHH"), "Team 2 defeated Team 6", "Example 1");
    is( whoWins("HHHHHH"), "Team 1 defeated Team 2", "Example 2");
    is( whoWins("HHHAHA"), "Team 4 defeated Team 2", "Example 3");
    is( whoWins("HAHAAH"), "Team 4 defeated Team 6", "Example 4");
    is( whoWins("HAAHAA"), "Team 5 defeated Team 1", "Example 5");

    done_testing;
}
