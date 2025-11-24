#!/usr/bin/perl
use 5.038;
use warnings;

my ($source, $target) = @ARGV;

my ($sourceHours, $sourceMinutes) = split /:/, $source;
my ($targetHours, $targetMinutes) = split /:/, $target;

if ($targetHours < $sourceHours) {
    $targetHours += 24;
}

my $diff = ($targetHours * 60 + $targetMinutes) -
    ($sourceHours * 60 + $sourceMinutes);
my @ops = (60, 15, 5, 1);
my $count = 0;

for my $op (@ops) {
        while ($diff >= $op) {
        $diff -= $op;
        $count++;
    }
}

say $count;

