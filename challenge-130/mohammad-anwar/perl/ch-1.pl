#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

is(odd_number(2, 5, 4, 4, 5, 5, 2), 5);
is(odd_number(1, 2, 3, 4, 3, 2, 1, 4, 4), 4);

sub odd_number {
    my @numbers = @_;

    my %count_of = ();
    map { $count_of{$_}++ } @numbers;

    foreach my $number (keys %count_of) {
        return $number if $count_of{$number} % 2 == 1;;
    }
}


done_testing;
