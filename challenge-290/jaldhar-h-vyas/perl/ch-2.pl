#!/usr/bin/perl
use v5.38;

sub sum {
    my $total;
    for my $n (@_) {
        $total += $n;
    }

    return $total;
}

my $str = shift // die "Need a string of digits\n";

my @digits = split //, $str;
my $checksum = pop @digits;
my $sum;

for my $k (reverse keys @digits) {
    if ($digits[$k] !~ /\d/) {
        next;
    }
    my $val = $k % 2 ? $digits[$k] * 2 : $digits[$k];
    $sum += $val > 9 ? sum(split //, $val) : $val;
}

say 10 - $sum % 10 == $checksum ? 'true' : 'false';
