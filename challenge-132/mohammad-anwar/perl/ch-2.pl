#!/usr/bin/perl

=head1

Week 132:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-132

Task #2: Hash Join

    Write a script to implement Hash Join algorithm as suggested by wikipedia.

=cut

use strict;
use warnings;

my @player_ages = (
    [20, "Alex"  ],
    [28, "Joe"   ],
    [38, "Mike"  ],
    [18, "Alex"  ],
    [25, "David" ],
    [18, "Simon" ],
);

my @player_names = (
    ["Alex", "Stewart"],
    ["Joe",  "Root"   ],
    ["Mike", "Gatting"],
    ["Joe",  "Blog"   ],
    ["Alex", "Jones"  ],
    ["Simon","Duane"  ],
);

my $names = {
    map {
        join(" ", @$_) => { f => $_->[0], l => $_->[1] }
    } @player_names
};

foreach my $player (@player_ages) {
    my $first_name = $player->[1];
    my $age        = $player->[0];
    foreach my $n (keys %$names) {
        if ($names->{$n}->{f} eq $first_name) {
            print "$age, $first_name, $names->{$n}->{l}\n";
        }
    }
}
