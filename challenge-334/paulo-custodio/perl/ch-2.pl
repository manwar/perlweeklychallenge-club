#!/usr/bin/env perl

# Perl Weekly Challenge 334 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-334/

use Modern::Perl;

my($x, $y) = split ' ', <>;
my @p;
while (<>) {
    push @p, [split ' ', $_];
}

say shortest_mnahattan_distance_index($x, $y, @p);

sub shortest_mnahattan_distance_index {
    my($x, $y, @p) = @_;
    my $min_dist = 1e10;
    my $min_index = -1;
    for my $i (0 .. $#p) {
        my($px, $py) = @{$p[$i]};
        next unless $x == $px || $y == $py;
        my $dist = abs($x-$px)+abs($y-$py);
        if ($dist < $min_dist) {
            $min_dist = $dist;
            $min_index = $i;
        }
    }
    return $min_index;
}
