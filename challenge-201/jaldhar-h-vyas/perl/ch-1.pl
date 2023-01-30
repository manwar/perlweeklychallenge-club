#!/usr/bin/perl
use 5.030;
use warnings;

my @array = @ARGV;
my @need = 0 .. scalar @array;

my %count;
for my $elem (@array, @need) {
    $count{$elem}++;
}

say join(q{, }), grep { $count{$_} < 2; } keys %count;
