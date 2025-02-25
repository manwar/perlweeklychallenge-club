#!/usr/bin/perl
use v5.38;

sub makeBag(@array) {
    my %bag;
    for my $elem (@array) {
        $bag{$elem}++;
    }

    return %bag;
}

sub max($first, $second) {
    return $first > $second ? $first : $second;
}

my @ints = @ARGV;

my %count = makeBag(@ints);
my $previous = 0;
my $without = 0;
my $current = 0;

for my $k (sort keys %count) {
    if ($k - 1 != $previous) {
        ($without, $current) = (max($without, $current), $k * $count{$k} + max($without, $current));
    } else {
        ($without, $current) = (max($without, $current), $k * $count{$k} + $without);
    }
    $previous = $k;
}

say max($without, $current);
