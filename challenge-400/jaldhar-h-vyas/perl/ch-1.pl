#!/usr/bin/perl
use 5.40.1;
use warnings;

sub max($a, $b) {
    return $a > $b ? $a : $b;
}

my ($int) = @ARGV;

my $biggestJump = 0;
my @nonrepeating = grep { $_ !~ / (\d) .* \1 /x } 1 .. $int;

for my $i (1 .. scalar @nonrepeating - 1) {
    $biggestJump = max($biggestJump, $nonrepeating[$i] - $nonrepeating[$i - 1]);
}

say $biggestJump;
