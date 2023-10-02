#!/usr/bin/perl
use 5.030;
use warnings;

sub classifyUnique {
    my %count;

    for my $n (@_) {
        $count{$n}++;
    }
    return grep { $count{$_} == 1; } keys %count;
}

sub sum {
    my $total = 0;

    for my $elem (@_) {
        $total += $elem;
    }

    return $total;
}

say sum(classifyUnique(@ARGV));