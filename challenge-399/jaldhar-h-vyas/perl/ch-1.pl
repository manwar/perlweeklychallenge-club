#!/usr/bin/perl
use 5.40.1;
use warnings;

sub max($a, $b) {
    return $a > $b ? $a : $b;
}

my ($str, $k) = @ARGV;

my @chars = split //, $str;
my %frequency;
my $maxCount = 0;
my $longestLength = 0;
my $left = 0;

for my ($right, $char) (indexed @chars) {
    $frequency{$char}++;
    $maxCount = max($maxCount, $frequency{$char});

    while ($right - $left + 1 - $maxCount > $k) {
        my $leftChar = $chars[$left];
        $frequency{$leftChar}--;
        $left++;
    }

    $longestLength = max($longestLength, $right - $left + 1);
}

say $longestLength;
