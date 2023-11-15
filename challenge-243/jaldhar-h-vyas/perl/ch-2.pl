#!/usr/bin/perl 
use 5.030;
use warnings;
use POSIX qw/ floor /;

my @nums = @ARGV;
my $sum = 0;

for my $i (@nums) {
    for my $j (@nums) {
        $sum += floor($i / $j);
    }
}

say $sum;
