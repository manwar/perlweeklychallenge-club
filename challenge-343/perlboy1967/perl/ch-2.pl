#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-343#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Champion Team
Submitted by: Mohammad Sajid Anwar

You have n teams in a tournament. A matrix grid tells you which team is stronger
between any two teams:

|| If grid[i][j] == 1, then team i is stronger than team j
|| If grid[i][j] == 0, then team j is stronger than team i

Find the champion team - the one with most wins, or if there is no single such
team, the strongest of the teams with most wins. (You may assume that there is a
definite answer.)

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(sum max);

sub championTeam (@grid) {
  my %w;

  # Process wins against teams
  for (0 .. $#grid) {
    push(@{$w{sum(@{$grid[$_]})}},$_);
  }

  # Get max scoring team(s)
  my @w = @{$w{max(keys(%w))}};

  # One winning team? Return it!
  return $w[0] if scalar @w == 1;

  # Multiple best scoring teams, find the best one
  my %uw = map { (sum(@{$grid[$_]}[@w]),$_) } @w;
  return $uw{max keys %uw};
}

is(championTeam([0,1,1],
                [0,0,1],
                [0,0,0]),
                0,q{Example 1});
is(championTeam([0,1,0,0],
                [0,0,0,0],
                [1,1,0,0],
                [1,1,1,0]),
                3,q{Example 2});
is(championTeam([0,1,0,1],
                [0,0,1,1],
                [1,0,0,0],
                [0,0,1,0]),
                0,q{Example 3});
is(championTeam([0,1,1],
                [0,0,0],
                [0,1,0]),
                0,q{Example 4});
is(championTeam([0,0,0,0,0],
                [1,0,0,0,0],
                [1,1,0,1,1],
                [1,1,0,0,0],
                [1,1,0,1,0]),
                2,q{Example 5});
is(championTeam([0,1,1,1,0,0],
                [0,0,1,0,1,1],
                [0,0,0,0,1,1],
                [0,1,1,0,1,1],
                [1,0,0,0,0,0],
                [1,0,0,0,1,0]),
                3,q{Matthias Muth's test});
done_testing;
