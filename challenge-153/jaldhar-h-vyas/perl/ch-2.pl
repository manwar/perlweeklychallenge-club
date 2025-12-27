#!/usr/bin/perl
use 5.038;
use warnings;
use Memoize;


sub factorial($n) {
    return ($n == 0) ? 1 : $n * factorial($n - 1);
}

sub sum(@arr) {
    my $total;
    for my $n (@arr) {
        $total += $n;
    }

    return $total;
}

memoize('factorial');

my ($n) = @ARGV;

say sum(map { factorial($_) } split //, $n) == $n ? 1 : 0;
