#!/usr/bin/perl
use 5.038;
use warnings;

sub max(@arr) {
    my $highest = '-inf';
    for my $i (@arr) {
        if ($i > $highest) {
            $highest = $i;
        }
    }

    return $highest;
}

my @valuables = @ARGV;
my @dp = (0, $valuables[0]);

for my $v (1 .. scalar @valuables - 1) {
    push @dp, max($dp[-1], ($dp[-2]) + $valuables[$v]);
}

say $dp[-1];
