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

sub sum {
    my $total;
    for my $n (@_) {
        $total += $n;
    }

    return $total;
}


say max(map { sum(split q{,}) } @ARGV);
