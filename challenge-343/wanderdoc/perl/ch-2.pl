#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You have n teams in a tournament. A matrix grid tells you which team is stronger between any two teams:

If grid[i][j] == 1, then team i is stronger than team j
If grid[i][j] == 0, then team j is stronger than team i

Find the champion team - the one with most wins, or if there is no single such team, the strongest of the teams with most wins. (You may assume that there is a definite answer.)

Example 1

Input: @grid = (
                 [0, 1, 1],
                 [0, 0, 1],
                 [0, 0, 0],
               )
Output: Team 0

[0, 1, 1] => Team 0 beats Team 1 and Team 2
[0, 0, 1] => Team 1 beats Team 2
[0, 0, 0] => Team 2 loses to all


Example 2

Input: @grid = (
                 [0, 1, 0, 0],
                 [0, 0, 0, 0],
                 [1, 1, 0, 0],
                 [1, 1, 1, 0],
               )
Output: Team 3

[0, 1, 0, 0] => Team 0 beats only Team 1
[0, 0, 0, 0] => Team 1 loses to all
[1, 1, 0, 0] => Team 2 beats Team 0 and Team 1
[1, 1, 1, 0] => Team 3 beats everyone


Example 3

Input: @grid = (
                 [0, 1, 0, 1],
                 [0, 0, 1, 1],
                 [1, 0, 0, 0],
                 [0, 0, 1, 0],
               )
Output: Team 0

[0, 1, 0, 1] => Team 0 beats teams 1 and 3
[0, 0, 1, 1] => Team 1 beats teams 2 and 3
[1, 0, 0, 0] => Team 2 beats team 0
[0, 0, 1, 0] => Team 3 beats team 2

Of the teams with 2 wins, Team 0 beats team 1.


Example 4

Input: @grid = (
                 [0, 1, 1],
                 [0, 0, 0],
                 [0, 1, 0],
               )
Output: Team 0

[0, 1, 1] => Team 0 beats Team 1 and Team 2
[0, 0, 0] => Team 1 loses to Team 2
[0, 1, 0] => Team 2 beats Team 1 but loses to Team 0


Example 5

Input: @grid = (
                 [0, 0, 0, 0, 0],
                 [1, 0, 0, 0, 0],
                 [1, 1, 0, 1, 1],
                 [1, 1, 0, 0, 0],
                 [1, 1, 0, 1, 0],
               )
Output: Team 2

[0, 0, 0, 0, 0] => Team 0 loses to all
[1, 0, 0, 0, 0] => Team 1 beats only Team 0
[1, 1, 0, 1, 1] => Team 2 beats everyone except self
[1, 1, 0, 0, 0] => Team 3 loses to Team 2
[1, 1, 0, 1, 0] => Team 4 loses to Team 2

=cut



use List::Util qw(sum max);
use Test2::V0 -no_srand => 1;
is(champion_team([0, 1, 1], 
                 [0, 0, 1], 
                 [0, 0, 0]), 0, 'Example 1');
is(champion_team([0, 1, 0, 0],
                 [0, 0, 0, 0],
                 [1, 1, 0, 0],
                 [1, 1, 1, 0]), 3, 'Example 2');

is(champion_team([0, 1, 0, 1],
                 [0, 0, 1, 1],
                 [1, 0, 0, 0],
                 [0, 0, 1, 0]), 0, 'Example 3');
is(champion_team([0, 1, 1],
                 [0, 0, 0],
                 [0, 1, 0]), 0, 'Example 4');
is(champion_team([0, 0, 0, 0, 0],
                 [1, 0, 0, 0, 0],
                 [1, 1, 0, 1, 1],
                 [1, 1, 0, 0, 0],
                 [1, 1, 0, 1, 0]), 2, 'Example 5');                 
                 
done_testing();


sub champion_team
{
     my @grid = @_;
     my %results;
     for my $i ( 0 .. $#grid )
     {
          my $sum = sum(@{$grid[$i]});
          $results{$i} = $sum;
     }
     my $max = max(values %results); 
     my @tied = grep { $results{$_} == $max } keys %results; 
     if ( scalar(@tied) == 1 ) { return $tied[0];}
     
     my %results_tied;
     for my $first ( @tied )
     {
          for my $second ( @tied )
          {
               $results_tied{$first} += $grid[$first][$second];
          }
     }
     my $max_tied = max( values %results_tied ); 
     my @wins = grep { $results_tied{$_} == $max_tied } keys %results_tied;
     return wantarray ? @wins : "@wins"; # tied is still possible.
}
