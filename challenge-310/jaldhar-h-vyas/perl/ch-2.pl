#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;
my @evens;
my @odds;

for my $k (keys @ints) {
    if ($k % 2 == 0) {
        push @evens, $ints[$k];
    } else {
        push @odds, $ints[$k];
    }
}

@evens = sort {$a <=> $b} @evens;
@odds = sort {$b <=> $a} @odds;

my @result;
while (@evens || @odds) {
    if (@evens) {
        push @result, shift @evens;
    }
    if (@odds) {
        push @result, shift @odds;
    }
}

say q{(}, (join q{, }, @result), q{)};
