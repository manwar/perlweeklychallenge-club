#!/usr/bin/perl
use 5.40.1;
use warnings;

sub toBase($number, $base) {
    if ($base < 2 || $base > 64) {
        die "base $base is out of range\n";
    }

    my @digits = (0 .. 9, 'A' .. 'Z', 'a' .. 'z', '+', '/')[0 .. $base - 1];
    my @result;

    if ($number == 0) {
        return 0;
    }

    while ($number > 0) {
        my $digit = int($number % $base);
        unshift @result, $digits[$digit];
        $number = int($number / $base);
    }

    return join q{}, @result;
}

my ($number, $base) = @ARGV;

say toBase($number, $base);