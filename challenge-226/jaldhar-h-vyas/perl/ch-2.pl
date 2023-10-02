#!/usr/bin/perl
use 5.030;
use warnings;

my @ints = @ARGV;
my $ops = 0;

while (scalar grep {$_ != 0} @ints) {
    my $pick = [sort { $a <=> $b } grep { $_ != 0 } @ints]->[0];
    @ints = map { $_ == 0 ? 0 : $_ - $pick } @ints;
    $ops++;
}

say $ops;
