#!/usr/bin/perl
use 5.038;
use warnings;

my @ints = @ARGV;
my @seen;
my @ans;
my $x = 0;

for my $i (keys @ints) {
    if ($ints[$i] == -1) {
        push @ans, ($x < scalar @seen) ? $seen[$x] : -1;
        $x++;
    } else {
        unshift @seen, $ints[$i];
        $x = 0;
    }
}


say  q{(}, (join q{, }, @ans), q{)};
