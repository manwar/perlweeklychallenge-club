use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@grid) {
    my %teams;
    for (my $i = 0; $i < scalar(@grid); $i++) {
        my $wins = 0;
        foreach my $team_result (@{$grid[$i]}) {
            $wins += $team_result;
        }
        $teams{$wins}->{$i} = {
            result => $grid[$i]
        };
    }

    foreach my $max_win (sort {$b <=> $a } keys(%teams)) {
        my $winner = undef;
        my @teams = keys %{$teams{$max_win}};
        $winner = $teams[0] if scalar(@teams) == 1;
        foreach my $team (@teams) {
            foreach (my $i = 0; $i < scalar(@{$teams{$max_win}->{$team}->{result}}); $i++) {
                if ($team != $i && exists $teams{$max_win}->{$i}) {
                    if ($teams{$max_win}->{$team}->{result}->[$i]) {
                        $winner = $team;
                    }
                }
            }
        }
        return "Team $winner";
    }
}

is(run([0, 1, 1], [0, 0, 1], [0, 0, 0]), "Team 0", "Example 1");
is(run([0, 1, 0, 0], [0, 0, 0, 0], [1, 1, 0, 0], [1, 1, 1, 0]), "Team 3", "Example 2");
is(run([0, 1, 0, 1], [0, 0, 1, 1], [1, 0, 0, 0], [0, 0, 1, 0]), "Team 0", "Example 3");
is(run([0, 1, 1], [0, 0, 0], [0, 1, 0]), "Team 0", "Example 4");
is(run([0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 1, 0, 1, 1], [1, 1, 0, 0, 0], [1, 1, 0, 1, 0]), "Team 2", "Example 5");
