#!/usr/bin/perl
use 5.030;
use warnings;

sub base {
    my ($number, $base) = @_;
    my @digits = (0 .. 9, 'A' .. 'Z');
    my @result;
    while ($number > ($base - 1)) {
        my $digit = $number % $base;
        push @result, $digits[$digit];
        $number /=  $base;
    }
    push @result, $digits[$number];

    return 0 + (join '', reverse @result);
}

my $n = shift // die "Need an integer.\n";

for my $B (2 .. $n - 2) {
    my @digits = split //, base($n, $B);
    if (!grep { $_ != $digits[0] } @digits) {
        say 1;
        exit;
    }
}

say 0;
