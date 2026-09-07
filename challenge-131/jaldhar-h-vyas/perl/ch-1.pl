#!/usr/bin/perl
use 5.40.1;
use warnings;

my @ints = @ARGV;
my @results;
push @results, [$ints[0]];

for my $i (1 .. scalar @ints - 1) {
    if ($ints[$i] - $ints[$i - 1] != 1) {
        push @results, [];
    }

    push @{$results[-1]}, $ints[$i];
}

say
    q{(},
        (join q{, }, (map { q{[} . (join q{, }, @{$_}) . q{]} } @results)),
    q{)};