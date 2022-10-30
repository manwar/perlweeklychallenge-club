#!/usr/bin/perl
use 5.030;
use warnings;

my ($x, $y) = @ARGV;
my $operations = 0;

do {
    my $prevX = $x;

    if ($x >= $y) {
        $x -= $y;
    }
    
    if ($y >= $prevX) {
        $y -= $prevX;
    }

    $operations++;

} while ($x != 0 && $y != 0);

say $operations;
