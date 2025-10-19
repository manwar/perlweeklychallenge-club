#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 343 Task 2  Champion Team
#=============================================================================
# You have n teams in a tournament. A matrix grid tells you which team is
# stronger between any two teams:
# If grid[i][j] == 1, then team i is stronger than team j
# If grid[i][j] == 0, then team j is stronger than team i
# Find the champion team - the one with most wins, or if there is no single
# such team, the strongest of the teams with most wins. (You may assume
# that there is a definite answer.)
#
# Example 1 Input: @grid = ( [0, 1, 1],
#                            [0, 0, 1],
#                            [0, 0, 0],)
#           Output: Team 0
#   [0, 1, 1] => Team 0 beats Team 1 and Team 2
#   [0, 0, 1] => Team 1 beats Team 2
#   [0, 0, 0] => Team 2 loses to all
#
# Example 2 Input: @grid = ( [0, 1, 0, 0],
#                            [0, 0, 0, 0],
#                            [1, 1, 0, 0],
#                            [1, 1, 1, 0],)
#           Output: Team 3
#   [0, 1, 0, 0] => Team 0 beats only Team 1
#   [0, 0, 0, 0] => Team 1 loses to all
#   [1, 1, 0, 0] => Team 2 beats Team 0 and Team 1
#   [1, 1, 1, 0] => Team 3 beats everyone
#
# Example 3 Input: @grid = ( [0, 1, 0, 1],
#                            [0, 0, 1, 1],
#                            [1, 0, 0, 0],
#                            [0, 0, 1, 0],)
#           Output: Team 0
#   [0, 1, 0, 1] => Team 0 beats teams 1 and 3
#   [0, 0, 1, 1] => Team 1 beats teams 2 and 3
#   [1, 0, 0, 0] => Team 2 beats team 0
#   [0, 0, 1, 0] => Team 3 beats team 2
#   Of the teams with 2 wins, Team 0 beats team 1.
#
# Example 4 Input: @grid = ( [0, 1, 1],
#                            [0, 0, 0],
#                            [0, 1, 0],)
#           Output: Team 0
#   [0, 1, 1] => Team 0 beats Team 1 and Team 2
#   [0, 0, 0] => Team 1 loses to Team 2
#   [0, 1, 0] => Team 2 beats Team 1 but loses to Team 0
#
# Example 5 Input: @grid = ( [0, 0, 0, 0, 0],
#                            [1, 0, 0, 0, 0],
#                            [1, 1, 0, 1, 1],
#                            [1, 1, 0, 0, 0],
#                            [1, 1, 0, 1, 0],)
#           Output: Team 2
#   [0, 0, 0, 0, 0] => Team 0 loses to all
#   [1, 0, 0, 0, 0] => Team 1 beats only Team 0
#   [1, 1, 0, 1, 1] => Team 2 beats everyone except self
#   [1, 1, 0, 0, 0] => Team 3 loses to Team 2
#   [1, 1, 0, 1, 0] => Team 4 loses to Team 2
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

# Supply rows as comma lists, example:
# perl ch-1.pl  0,1,1  0,0,1  0,0,0
my @GRID = map { [ split(',', $_) ] } @ARGV;
say join " ", map { !defined($_) ? "NONE" : $_ } champion(@GRID);

#=============================================================================
sub champion(@grid)
{
    use List::Util qw/max sum any/;
    use List::MoreUtils qw/indexes/;

    my @strength = map { sum($_->@*) } @grid;
    my $maxStrength = max @strength;
    my @strongest = indexes { $_ == $maxStrength } @strength;

    # Eliminate losers
    my @champ = grep { my $t = $_; ! any { $grid[$_][$t]} @strongest } @strongest;

    # For a possible tie, return a list. If no champions, it's an N-way tie.
    return ( @champ > 0 ? "@champ" : "@strongest" );
}

sub runTest
{
    use Test2::V0;

    my @case = (
        { case => "Example 1", expect => 0,
          input => [ [0,1,1], [0,0,1], [0,0,0] ]
        } ,
        { case => "Example 2", expect => 3,
          input => [ [0,1,0,0], [0,0,0,0], [1,1,0,0], [1,1,1,0] ],
        } ,
        { case => "Example 3", expect => 0,
          input => [ [0,1,0,1], [0,0,1,1], [1,0,0,0], [0,0,1,0] ]
        } ,
        { case => "Example 4", expect => 0,
          input => [ [0,1,1], [0,0,0], [0,1,0] ]
        } ,
        { case => "Example 5", expect => 2,
          input => [ [0,0,0,0,0], [1,0,0,0,0], [1,1,0,1,1], [1,1,0,0,0], [1,1,0,1,0]  ]
        } ,
        { case => "Rock paper scissors", expect => "0 1 2",
          input => [ [0,0,1], [1,0,0], [0,1,0] ]
        } ,
        { case => "Tied ", expect => "1 3",
          input => [ [0,0,0,0,0,0], [0,0,0,0,1,1], [0,0,0,0,0,0], [1,0,1,0,0,0], [0,0,0,0,0], [0,0,0,0,0,0]  ]
        } ,
    );

    for ( @case )
    {
        is( champion( $_->{input}->@* ), $_->{expect}, $_->{case});
    }

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
