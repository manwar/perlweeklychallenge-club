#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Time::Local;

my @player_names = (
    ["Alex", "Stewart"],
    ["Joe",  "Root"   ],
    ["Mike", "Gatting"],
    ["Joe",  "Blog"   ],
    ["Alex", "Jones"  ],
    ["Simon","Duane"  ],
    );

my %names;
for my $name (@player_names) {
    push @{$names{$name->[0]}}, $name->[1];
}
for my $pl_age (@player_ages) {
    my ($age, $first_name) = @$pl_age;
    next unless exists $names{$first_name};
    for my $name (@{$names{$first_name}}) {
        say "$age $first_name $name";
    }
}
