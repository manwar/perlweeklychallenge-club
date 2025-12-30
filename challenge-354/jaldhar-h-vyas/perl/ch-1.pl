#!/usr/bin/perl
use 5.038;
use warnings;

sub min(@arr) {
    my $lowest = 'inf';
    for my $i (@arr) {
        if ($i < $lowest) {
            $lowest = $i;
        }
    }

    return $lowest;
}

my @ints = @ARGV;
my @sorted = sort{ $a <=> $b } @ints;
my %mins;

for my $i (1 .. scalar @sorted - 1) {
    my $minAbsDiff = $sorted[$i] - $sorted[$i - 1];
    push @{$mins{$minAbsDiff}}, [ $sorted[$i - 1], $sorted[$i] ];
}

say join q{, }, map { q{[} . (join  q{, }, @{$_}) . q{]} } @{$mins{ min(keys %mins) }};