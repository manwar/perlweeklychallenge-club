#!/usr/bin/perl
use 5.40.1;
use warnings;

my @array = @ARGV;
my $count = 0;

for my $i (0 .. scalar @array - 1) {
    for my $j ($i + 1 .. scalar @array - 1) {
        if ($array[$j] =~ /(?= ^$array[$i]) .* (?= $array[$i]$)/x) {
            $count++;
        }
    }
}

say $count;
