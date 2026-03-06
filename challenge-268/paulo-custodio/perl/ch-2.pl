#!/usr/bin/env perl

use Modern::Perl;

say "(", join(", ", number_game(@ARGV)), ")";

sub number_game {
    my(@ints) = @_;
    my @out;
    while (@ints) {
        @ints = sort {$a <=> $b} @ints;
        push @out, $ints[1], $ints[0];
        splice @ints, 0, 2;
    }
    return @out;
}
