#!/usr/bin/perl

use v5.40;

use Test::More tests => 2;

use List::Util qw(reduce);

sub pair {
    @_ == 2 ? [ $_[0], $_[1] ]
            : ((map { [ $_[0], $_ ] } @_[1..$#_]), pair(@_[1..$#_]));
}

sub get_distance {
    grep { $_ == 1 } split //, sprintf "%b", $_[0] ^ $_[1];
}

sub add_distances {
    reduce { $a + $b } map { get_distance($_->[0], $_->[1]) } pair(@_);
}

is(add_distances(4, 14, 2), 6);
is(add_distances(4, 14, 4), 4);
