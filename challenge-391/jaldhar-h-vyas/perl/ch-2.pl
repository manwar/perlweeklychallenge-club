#!/usr/bin/perl
use 5.40.1;
use warnings;

sub max(@arr) {
    my $largest = $arr[0];
    for my $i (@arr) {
        if ($i > $largest) {
            $largest = $i;
        }
    }

    return $largest;
}

my @boxes = map { [split /\s+/, $_ ] } @ARGV;
@boxes = sort { $a->[0] <=> $b->[0] || $b->[1] <=> $a->[1] } @boxes;

my @longest = map { 1 } @boxes;
for my $i (keys @boxes) {
    for my $j (0 .. $i - 1) {
        if ($boxes[$j][0] < $boxes[$i][0] && $boxes[$j][1] < $boxes[$i][1]) {
            $longest[$i] = max($longest[$i], $longest[$j] + 1);
        }
    }
}

say max(@longest);
