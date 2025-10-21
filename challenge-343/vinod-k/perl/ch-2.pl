#!/usr/bin/perl
use strict;
use warnings;

sub find_champion {
    my @grid = @_;
    my $n = scalar @grid;

    my @wins = (0) x $n;
    my @beaten = ();

    for my $i (0..$n-1) {
        my @beat_teams = ();
        for my $j (0..$n-1) {
            if ($grid[$i][$j] == 1) {
                $wins[$i]++;
                push @beat_teams, $j;
            }
        }
        $beaten[$i] = \@beat_teams;
    }

    for my $i (0..$n-1) {
        my $beat_list = join ', ', map { "Team $_" } @{$beaten[$i]};
        if ($beat_list eq '') {
            print "[" . join(", ", @{$grid[$i]}) . "] => Team $i loses to all\n";
        } else {
            print "[" . join(", ", @{$grid[$i]}) . "] => Team $i beats $beat_list\n";
        }
    }

    my $max_wins = 0;
    for my $w (@wins) {
        $max_wins = $w if $w > $max_wins;
    }

    my @max_win_teams = grep { $wins[$_] == $max_wins } 0..$n-1;

    my $champion;
    if (scalar @max_win_teams == 1) {
        $champion = $max_win_teams[0];
    } else {
        foreach my $team (@max_win_teams) {
            my $is_strongest = 1;
            foreach my $other (@max_win_teams) {
                next if $team == $other;
                if ($grid[$team][$other] == 0) {
                    $is_strongest = 0;
                    last;
                }
            }
            if ($is_strongest) {
                $champion = $team;
                last;
            }
        }
    }
    print "\nOutput: Team $champion\n\n";
}

my @tests = (
    [
        [0, 1, 1],
        [0, 0, 1],
        [0, 0, 0],
    ],
    [
        [0, 1, 0, 0],
        [0, 0, 0, 0],
        [1, 1, 0, 0],
        [1, 1, 1, 0],
    ],
    [
        [0, 1, 0, 1],
        [0, 0, 1, 1],
        [1, 0, 0, 0],
        [0, 0, 1, 0],
    ],
    [
        [0, 1, 1],
        [0, 0, 0],
        [0, 1, 0],
    ],
    [
        [0, 0, 0, 0, 0],
        [1, 0, 0, 0, 0],
        [1, 1, 0, 1, 1],
        [1, 1, 0, 0, 0],
        [1, 1, 0, 1, 0],
    ],
);

for my $idx (0..$#tests) {
    print "Example ", $idx+1, ":\n";
    find_champion(@{$tests[$idx]});
}
