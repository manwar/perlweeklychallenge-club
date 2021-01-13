#!/usr/bin/env perl

use v5.30;
use warnings;

my $A = $ARGV[0];
my $B = $ARGV[1];

defined $A and defined $B or die "Usage: $0 <A> <B>";

my @summands;
my $total = 0;

while ($A >= 1) {
    say "$A & $B";

    if ($A % 2 == 1) {
        push @summands, $B;
        $total += $B;
    }

    $A = int($A / 2);
    $B *= 2;
}

say join(" + ", @summands), " = ", $total;