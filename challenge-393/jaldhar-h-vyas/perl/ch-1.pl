#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($n) = @ARGV;
my $count = 0;

for my $a (1 .. $n) {
    for my $b (1 .. $n) {
        my $c = sqrt($a ** 2 + $b ** 2);
        if  ($c <= $n && int($c) == $c) {
            $count++;
        }
    }
}

say $count;
