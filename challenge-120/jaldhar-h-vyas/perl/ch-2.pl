#!/usr/bin/perl
use 5.020;
use warnings;

sub min {
    my ($a, $b) = @_;

    return $a < $b ? $a : $b;
}

my $T = shift // die "Must specify a time (hh:mm).\n";
my ($hours, $mins) = split q{:}, $T;

my $hangle = ($hours % 12) * 30 + ($mins / 60 ) * 30;
my $mangle = $mins * 6;
my $diff = abs($hangle - $mangle);
my $angle = min($diff, 360 - $diff);

say "$angle degree", ($angle != 1 ? 's' : q{});

