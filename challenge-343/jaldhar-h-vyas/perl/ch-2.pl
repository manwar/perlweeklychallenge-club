#!/usr/bin/perl
use 5.038;;
use warnings;

my @grid;
my @wins;

for my $arg (@ARGV) {
    my @row = split /\s+/, $arg;
    push @grid, \@row;
    push @wins,  scalar grep { $_ } @row;
}

my $max  = (sort {$a <=> $b} @wins)[-1];
my @candidates = grep { $wins[$_] == $max } keys @wins;
my $champion = $candidates[0];

for my $candidate (@candidates[1 .. $#candidates]) {
    if ($grid[$champion]->[$candidate] == 0) {
        $champion = $candidate;
    }
}

say $champion;
