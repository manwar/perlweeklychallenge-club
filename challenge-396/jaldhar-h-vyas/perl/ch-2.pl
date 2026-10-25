#!/usr/bin/perl
use 5.40.1;
use warnings;

my @arr = @ARGV;
my $n = scalar @arr;
my $index = 1;
my $isTrionic = false;

while ($index < $n && $arr[$index] > $arr[$index - 1]) {
    $index++;
}

my $peakIndex = $index - 1;

if ($peakIndex > 0 && $index < $n) {
    while ($index < $n && $arr[$index] < $arr[$index - 1]) {
        $index++;
    }

    my $valleyIndex = $index - 1;

    if ($valleyIndex > $peakIndex && $index < $n) {
        while ($index < $n && $arr[$index] > $arr[$index - 1]) {
            $index++;
        }

        $isTrionic = $index == $n;
    }
}

say $isTrionic ? 'true' : 'false';
