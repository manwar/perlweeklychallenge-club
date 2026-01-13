use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub game($result, $team1, $team2) {
    return $result eq 'H' ? $team1 : $team2;
}

sub run($results) {
    my @results = split //, $results;
    my @first_round_winners = sort { $a <=> $b } (game($results[0], 2, 7), game($results[1], 3, 6), game($results[2], 4, 5));
    my @playoff_winners = sort { $a <=> $b } (game($results[3], 1, $first_round_winners[2]), game($results[4], $first_round_winners[0], $first_round_winners[1]));
    my $winner = game($results[5], $playoff_winners[0], $playoff_winners[1]);

    return "Team $winner defeated Team " . ($playoff_winners[0] == $winner ? $playoff_winners[1] : $playoff_winners[0]);

}

is(run('HAHAHH'), 'Team 2 defeated Team 6', 'Example 1');
is(run('HHHHHH'), 'Team 1 defeated Team 2', 'Example 2');
is(run('HHHAHA'), 'Team 4 defeated Team 2', 'Example 3');
is(run('HAHAAH'), 'Team 4 defeated Team 6', 'Example 4');
is(run('HAAHAA'), 'Team 5 defeated Team 1', 'Example 5');
