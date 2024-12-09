#!/usr/bin/perl
use v5.38;

my @intervals = map { [ split /\s+/ ] } @ARGV;

my %startIndices;
for my $k (keys @intervals) {
    $startIndices{$intervals[$k]->[0]} = $k;
}
my @starts = sort { $a <=> $b } map { $_->[0] } @intervals;
my @result;

for my $interval (@intervals) {
    my $end = $interval->[1];
    my $rightInterval;

    for my $first (@starts) {
        if ($first >= $end) {
            $rightInterval = $first;
            last;
        }
    }

    if (defined $rightInterval) {
        push @result, $startIndices{$rightInterval};
    } else {
        push @result, -1;
    }
}

say q{(}, (join q{, }, @result), q{)};

