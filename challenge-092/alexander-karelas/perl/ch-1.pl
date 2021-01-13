#!/usr/bin/env perl

use v5.30;
use warnings;

# args
my ($A, $B) = @ARGV;
length $A and length $B or die "Usage: $0 \$A \$B";

# pre-check
length $A == length $B or say(0), exit;

# start
my (%a_to_b, %b_to_a);

my @a = split //, $A;
my @b = split //, $B;

while (@a) {
    my $x = shift @a;
    my $y = shift @b;

    if (exists $a_to_b{$x} or exists $b_to_a{$y}) {
        ($a_to_b{$x} // '') eq $y and ($b_to_a{$y} // '') eq $x or say(0), exit;
    }

    $a_to_b{$x} //= $y;
    $b_to_a{$y} //= $x;
}

say 1;
