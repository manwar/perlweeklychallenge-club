#!/usr/bin/perl
use 5.40.1;
use warnings;
use Math::Round qw/ round /;

sub sum(@arr) {
    my $total;
    for my $n (@arr) {
        $total += $n;
    }

    return $total;
}

my @arr = @ARGV;

my @a = grep { $_ % 6 == 0 } @arr;
say scalar @a ? round(sum(@a) / scalar @a) : 0;