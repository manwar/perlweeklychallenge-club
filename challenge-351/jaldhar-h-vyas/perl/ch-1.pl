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

sub min(@arr) {
    my $lowest = 'inf';
    for my $i (@arr) {
        if ($i < $lowest) {
            $lowest = $i;
        }
    }

    return $lowest;
}

sub sum(@arr) {
    my $total;
    for my $n (@arr) {
        $total += $n;
    }

    return $total;
}

my @ints = @ARGV;

@ints = grep { $_ != min(@ints) } grep { $_ != max(@ints) } @ints;

say @ints ? sum(@ints) / @ints : 0;
