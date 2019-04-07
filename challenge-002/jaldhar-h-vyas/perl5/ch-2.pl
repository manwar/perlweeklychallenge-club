#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub usage {
    print <<"-USAGE-";
    Usage:
    $0 -f <number>
    $0 -t <number>

    -f          convert base 35 number to base 10
    -t          convert base 10 number to base 35
    <number>    the number to convert
-USAGE-
    exit(1);
}

sub fromBase35 {
    my ($number) = @_;
    my $scale = (length $number) - 1;
    my %digits;
    @digits{(0 .. 9, 'A' .. 'Y')} = 0 .. 34;
    my $result;

    for my $digit (split '', $number) {
        my $base10 = $digits{uc $digit} // die "malformed base-35 number\n";
        $result += $base10 * 35 ** $scale;
        $scale--;
    }

    return $result;
}

sub toBase35 {
    my ($number) = @_;
    my @digits = (0 .. 9, 'A' .. 'Y');
    my @result;
    while ($number > 34) {
        my $digit = int($number / 35);
        push @result, $digits[$digit];
        $number -= ($digit * 35);
    }
    push @result, $digits[$number];

    return join '', @result;
}

if (scalar @ARGV < 2) {
   usage();
}

if ($ARGV[0] eq '-f') {
   say fromBase35($ARGV[1]);
} elsif ($ARGV[0] eq '-t') {
   say toBase35($ARGV[1]);
else {
   usage();
}


