#!/usr/bin/perl
use 5.40.1;
use warnings;

sub fromBase($number, $base) {
    if ($base < 2 || $base > 64) {
        die "base $base is out of range\n";
    }

    my $scale = (length $number) - 1;
    my %digits;
    @digits{0..9, 'A'..'Z', 'a'..'z', '+', '/'} = 0 .. $base - 1;

    my $result;

    for my $digit (split //, $number) {
        my $base10 = $digits{$digit} // die "malformed base-$base number\n";
        $result += $base10 * $base ** $scale;
        $scale--;
    }

    return $result;
}

my ($number, $base) = @ARGV;

say fromBase($number, $base);