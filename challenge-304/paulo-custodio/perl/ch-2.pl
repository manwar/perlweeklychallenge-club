#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(sum max);

my @nums = split ' ', <>;
my $n = <>;

say sprintf("%.2f", max_average($n, @nums));

sub max_average {
    my($n, @nums) = @_;
    my $max = -1e10;
    for my $i (0 .. @nums-$n) {
        my $sum = sum(@nums[$i .. $i+$n-1]);
        $max = max($max, $sum);
    }
    return $max/$n;
}
