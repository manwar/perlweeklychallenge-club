#!/usr/bin/perl
use 5.038;
use warnings;
use builtin qw/ true false /;
no warnings qw/ experimental::builtin /;

my @nums = sort { $a <=> $b } @ARGV;
my $difference = abs($nums[1] - $nums[0]);
my $isArithmeticProgression = true;

for my $i (2 .. scalar @nums - 1) {
    if ($nums[$i] - $nums[$i - 1] != $difference) {
        $isArithmeticProgression = false;
        last;
    }
}

say $isArithmeticProgression ? 'true' : 'false';
